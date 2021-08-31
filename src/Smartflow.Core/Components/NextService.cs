﻿/********************************************************************
 License: https://github.com/chengderen/Smartflow/blob/master/LICENSE 
 Home page: http://www.smartflow-sharp.com
 Github : https://github.com/chengderen/Smartflow-Sharp
 ********************************************************************
 */
using System;
using System.Collections.Generic;
using System.Linq;
using Smartflow.Core.Elements;

namespace Smartflow.Core.Components
{
    public class NextService: JumpService
    {
        public NextService(IWorkflowMarker marker) : base(marker)
        {

        }

        public void Next(WorkflowJumpContext context)
        {
            WorkflowInstance instance = WorkflowInstance.GetInstance(context.InstanceID);
            Node current = instance.Current.FirstOrDefault(e => e.NID == context.NodeID);
            Transition transition = current.Transitions.FirstOrDefault();
            IList<Node> nodes = WorkflowService.NodeService.Query(instance.InstanceID);
            Node to = nodes.FirstOrDefault(e => e.ID == transition.Destination);
            this.Invoke(transition, new ExecutingContext
            {
                From = current,
                To = to,
                Direction = WorkflowOpertaion.Go,
                InstanceID = instance.InstanceID,
                Data = context.Data,
                Message = context.Message
            }, context);
        }

        private void Next(WorkflowJumpContext context, Transition transition)
        {
            WorkflowInstance instance = WorkflowInstance.GetInstance(context.InstanceID);
            IList<Node> nodes = WorkflowService.NodeService.Query(instance.InstanceID);
            Node current = nodes.FirstOrDefault(e => e.NID == context.NodeID);
            Node to = nodes.FirstOrDefault(e => e.ID == transition.Destination);
            this.Invoke(transition, new ExecutingContext
            {
                From = current,
                To = to,
                Direction = WorkflowOpertaion.Go,
                InstanceID = instance.InstanceID,
                Data = context.Data,
                Message = context.Message
            }, context);
        }

        private void Invoke(Transition selectTransition, ExecutingContext executeContext, WorkflowJumpContext context)
        {
            WorkflowInstance instance = WorkflowInstance.GetInstance(context.InstanceID);
            if (instance.State == WorkflowInstanceState.Running)
            {
                string instanceID = context.InstanceID;
                Node to = executeContext.To;
                WorkflowService.InstanceService.Jump(selectTransition.Origin, selectTransition.Destination, instanceID, new WorkflowProcess()
                {
                    RelationshipID = executeContext.From.NID,
                    CreateTime = DateTime.Now,
                    ActorID = context.ActorID,
                    Origin = executeContext.From.ID,
                    Destination = executeContext.To.ID,
                    TransitionID = selectTransition.NID,
                    InstanceID = executeContext.InstanceID,
                    NodeType = executeContext.From.NodeType,
                    Direction = WorkflowOpertaion.Go
                }, WorkflowService.ProcessService);

                WorkflowService.Actions.ForEach(pluin => pluin.ActionExecute(executeContext));
                if (to.NodeType == WorkflowNodeCategory.End)
                {
                    WorkflowService.InstanceService.Transfer(WorkflowInstanceState.End, instanceID);
                }
                else if (to.NodeType == WorkflowNodeCategory.Decision)
                {
                    Transition transition = WorkflowService.NodeService.GetTransition(to);
                    if (transition == null) return;
                    Next(new WorkflowJumpContext()
                    {
                        InstanceID = instanceID,
                        NodeID = to.NID,
                        Data = context.Data,
                        Message = "系统流转",
                        ActorID = context.ActorID

                    }, transition);
                }
                else if (to.NodeType == WorkflowNodeCategory.Fork)
                {
                    foreach (Transition transition in to.Transitions)
                    {
                        Next(new WorkflowJumpContext()
                        {
                            InstanceID = instanceID,
                            NodeID = to.NID,
                            Data = context.Data,
                            Message = "系统流转",
                            ActorID = context.ActorID
                        }, transition);
                    }
                }
                else if (to.NodeType == WorkflowNodeCategory.Merge)
                {
                    IList<Transition> transitions = WorkflowGlobalServiceProvider.Resolve<IWorkflowTransitionService>().Query(instanceID);
                    int linkCount = WorkflowGlobalServiceProvider.Resolve<IWorkflowLinkService>().GetLink(to.ID, instanceID);
                    if (transitions.Count(e => e.Destination == to.ID) == linkCount)
                    {
                        foreach (Transition transition in to.Transitions)
                        {
                            Next(new WorkflowJumpContext()
                            {
                                InstanceID = instanceID,
                                NodeID = to.NID,
                                Data = context.Data,
                                Message = "系统流转",
                                ActorID = context.ActorID
                            }, transition);
                        }
                    }
                }
            }

            base.Invoke(new WorkflowMarkerArg(executeContext.To, WorkflowOpertaion.Go, typeof(NextService).Name), () => WorkflowService.InstanceService.Transfer(WorkflowInstanceState.Hang, instance.InstanceID), () => WorkflowService.InstanceService.Transfer(WorkflowInstanceState.Running, instance.InstanceID));
        }
    }
}

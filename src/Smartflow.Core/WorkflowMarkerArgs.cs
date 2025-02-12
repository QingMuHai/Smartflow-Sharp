﻿using Smartflow.Core.Elements;
using System;
using System.Collections.Generic;
using System.Text;

namespace Smartflow.Core
{
    public class WorkflowMarkerArgs : System.EventArgs
    {
        public Node Node
        {
            get; private set;
        }

        public string Command
        {
            get; private set;
        }

        public WorkflowOpertaion Direction
        {
            get; private set;
        }

        public WorkflowMarkerArgs(Node node, WorkflowOpertaion direction, string command)
        {
            this.Node = node;
            this.Direction = direction;
            this.Command = command;
        }
    }
}

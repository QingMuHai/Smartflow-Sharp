﻿using Smartflow.Core.Elements;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using NHibernate;
using Smartflow.Common;

namespace Smartflow.Core
{
    public class WorkflowOrganizationService : IWorkflowParse
    {
        public Element Parse(XElement element)
        {
            return new Organization
            {
                Name = element.Attribute("name").Value,
                ID = element.Attribute("id").Value
            };
        }
    }
}

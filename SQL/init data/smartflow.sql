USE [Smartflow.Core]
GO
INSERT [dbo].[t_category] ([NID], [Name], [Url], [ParentID]) VALUES (N'001', N'Smartflow-Sharp', NULL, N'00')
GO
INSERT [dbo].[t_category] ([NID], [Name], [Url], [ParentID]) VALUES (N'001001', N'请假流程', N'./vacation/detail.html', N'001')
GO
INSERT [dbo].[t_config] ([ID], [Name], [ConnectionString], [ProviderName]) VALUES (1, N'业务库', N'server=127.0.0.1;database=Demo;uid=chengderen;pwd=123456', N'System.Data.SqlClient')
GO
INSERT [dbo].[t_constraint] ([NID], [Name], [Sort]) VALUES (N'node_send_latest_user', N'按上节点的审批人部门筛选', 2)
GO
INSERT [dbo].[t_constraint] ([NID], [Name], [Sort]) VALUES (N'node_send_start_user', N'按发起人部门筛选', 1)
GO
INSERT [dbo].[t_script] ([ID], [CategoryCode], [Text], [Sort]) VALUES (N'1AEC1690-2396-4C85-AA29-2B6BE8F563D0', N'001001', N'DELETE FROM [Demo].[dbo].[t_vacation] where NID=@ID', 1)
GO
INSERT [dbo].[t_structure] ([NID], [Name], [Resource], [CategoryCode], [CategoryName], [Status], [Memo], [CreateTime]) VALUES (N'2FD587EE-484B-4454-8DD2-D70DE0E6A700', N'并行流程', N'<workflow><start id="32" name="开始" layout="214 -9 103 -9" cooperation="" assistant="" category="start" veto="0" back="" url=""><transition name="提交部门主管审批1" destination="36" layout="264,103 286,103" id="39"/></start><end id="33" name="结束" layout="857 -17 113 -14" cooperation="" assistant="" category="end" veto="0" back="" url=""/><node id="34" name="副总经理" layout="596 83 48 5" cooperation="" assistant="" category="node" veto="0" back="" url=""><group id="0b00a3cd-8d42-47c2-88b6-38411996aeb3" name="副总经理"/><carbon id="19AC63B1-23F0-448F-9DEE-48A6A907D09F" name="武松"/><carbon id="1C71A1B0-B5AB-46E0-9640-D5A1CEC572CD" name="吴用"/><transition name="合并" destination="38" layout="736,68 795,102" id="40"/></node><node id="35" name="总经理" layout="598 86 136 8" cooperation="Smartflow.Components.DemocraticDecision" assistant="Smartflow.Components.RequiredStrategyService" category="node" veto="0" back="Smartflow.Components.BackService" url=""><group id="7f47f184-2fda-428a-8d00-446f809d136d" name="总经理"/><actor id="2223DE46-BDB2-448B-9C25-1221148E8EC9" name="魏文彬"/><actor id="2A5EEE6D-534D-4D13-BDF4-E47E0B646D1A" name="张一帆"/><transition name="合并" destination="38" layout="738,156 795,122" id="41"/></node><node id="36" name="部门主管" layout="286 58 83 11" cooperation="" assistant="" category="node" veto="0" back="" url=""><group id="09430824-bda1-43de-8310-91aab3c532e2" name="财务经理"/><group id="0b00a3cd-8d42-47c2-88b6-38411996aeb3" name="副总经理"/><group id="392d3783-9bf3-43de-829c-89bf2fe02633" name="经理"/><group id="3bdd332c-b333-4194-b84c-728434606b58" name="主管"/><group id="4fcb4d1d-3bd0-4178-b82e-9f1c8905fa7d" name="采购经理"/><group id="7f47f184-2fda-428a-8d00-446f809d136d" name="总经理"/><group id="e26803fa-2f46-43fa-9d78-5374e7aff46b" name="财务主管"/><group id="f9e1e931-3b5c-414a-8598-d559c4c33697" name="销售总监"/><rule id="node_send_start_user" name="按发起人部门筛选"/><transition name="提交同步分支" destination="37" layout="426,103 453,102" id="42"/></node><fork id="37" name="分叉" layout="453 25 92 -4" cooperation="" assistant="" category="fork" veto="0" back="" url=""><transition name="提交副总经理审批" destination="34" layout="533,102 596,68" id="43"/><transition name="提交总经理审批" destination="35" layout="533,102 598,156" id="44"/></fork><merge id="38" name="聚合" layout="775 -17 112 -8" cooperation="" assistant="" category="merge" veto="0" back="" url=""><transition name="结束" destination="33" layout="805,112 867,113" id="45"/></merge></workflow>', N'001001', N'请假流程', 0, N'并行流程', CAST(N'2020-08-24T21:22:05.973' AS DateTime))
GO
INSERT [dbo].[t_structure] ([NID], [Name], [Resource], [CategoryCode], [CategoryName], [Status], [Memo], [CreateTime]) VALUES (N'9AA6B216-8A95-47FF-A1B2-4C01F504ECBD', N'分支', N'<workflow><start id="32" name="开始" layout="289 -17 103 -3" cooperation="" assistant="" category="start" veto="0" back="" url=""><transition name="提交部门主管审阅" destination="34" layout="319,123 319,162" id="38"/></start><end id="33" name="结束" layout="289 -9 369 -1" cooperation="" assistant="" category="end" veto="0" back="" url=""/><node id="34" name="部门主管" layout="249 74 162 21" cooperation="" assistant="" category="node" veto="0" back="" url=""><group id="09430824-bda1-43de-8310-91aab3c532e2" name="财务经理"/><group id="0b00a3cd-8d42-47c2-88b6-38411996aeb3" name="副总经理"/><group id="392d3783-9bf3-43de-829c-89bf2fe02633" name="经理"/><group id="3bdd332c-b333-4194-b84c-728434606b58" name="主管"/><group id="e26803fa-2f46-43fa-9d78-5374e7aff46b" name="财务主管"/><group id="f9e1e931-3b5c-414a-8598-d559c4c33697" name="销售总监"/><rule id="node_send_start_user" name="按发起人部门筛选"/><transition name="提交分支判断" destination="36" layout="319,202 319,251" id="39"/></node><node id="35" name="副总经理" layout="82 54 255 4" cooperation="" assistant="" category="node" veto="0" back="" url=""><group id="0b00a3cd-8d42-47c2-88b6-38411996aeb3" name="副总经理"/><transition name="结束" destination="33" layout="152,295 149,368 299,369" id="40"><marker x="144" y="363" length="108"/></transition></node><decision id="36" name="分支节点" layout="269 38 276 -15" cooperation="" assistant="" category="decision" veto="0" back="" url=""><command><text><![CDATA[SELECT * FROM [dbo].[t_vacation] WHERE NID IN (SELECT  [KEY]  FROM [Smartflow.Core].[dbo].[t_bridge] WHERE InstanceID=@InstanceID)]]></text><id><![CDATA[1]]></id></command><transition name="提交副总经理审批" destination="35" layout="269,276 222,275" id="41"><expression><![CDATA[Day>7]]></expression></transition><transition name="结束" destination="33" layout="319,301 319,349" id="42"><expression><![CDATA[Day<7]]></expression></transition></decision></workflow>', N'001001', N'请假流程', 1, N'分支', CAST(N'2020-06-06T10:30:16.650' AS DateTime))
GO
INSERT [dbo].[t_structure] ([NID], [Name], [Resource], [CategoryCode], [CategoryName], [Status], [Memo], [CreateTime]) VALUES (N'E18D2E9F-94A0-4E01-ABAB-C39B8196E7FD', N'普通流程', N'<workflow><start id="32" name="开始" layout="332 0 126 0" cooperation="" assistant="" category="start" veto="0" back="" url=""><transition name="提交部门主管审批" destination="34" layout="362,146 363,183" id="36"/></start><end id="33" name="结束" layout="334 -2 376 -11" cooperation="" assistant="" category="end" veto="0" back="" url=""/><node id="34" name="部门主管" layout="293 85 183 5" cooperation="" assistant="" category="node" veto="0" back="" url=""><group id="0b00a3cd-8d42-47c2-88b6-38411996aeb3" name="副总经理"/><group id="7f47f184-2fda-428a-8d00-446f809d136d" name="总经理"/><action id="Smartflow.Bussiness.WorkflowService.EmptyAction" name="EmptyAction"/><actor id="3D041013-4844-4412-BC8B-DD73FD59E173" name="石勇"/><rule id="node_send_start_user" name="按发起人部门筛选"/><transition name="提交总经理审批" destination="35" layout="363,223 364,265" id="37"/></node><node id="35" name="总经理" layout="294 92 265 18" cooperation="" assistant="" category="node" veto="0" back="Smartflow.Components.BackService" url=""><group id="7f47f184-2fda-428a-8d00-446f809d136d" name="总经理"/><transition name="结束" destination="33" layout="364,305 364,356" id="38"/></node></workflow>', N'001001', N'请假流程', 0, N'普通流程', CAST(N'2020-08-30T13:31:57.313' AS DateTime))
GO

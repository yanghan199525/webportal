using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyLib;
using System.Text;
using System.Data;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.OrgChart.Interface;
using Ultimus.UWF.Common.Logic;

namespace Ultimus.UWF.OrgChart
{
    public partial class SelectUser : System.Web.UI.Page
    {
        IOrg _org;
        public static string __tvScroll = string.Empty;//滚动条位置 
        public static string __userScroll = string.Empty;//滚动条位置 
        protected void Page_Load(object sender, EventArgs e)
        {
            _org = ServiceContainer.Instance().GetService<IOrg>();
            __tvScroll = txtTVScroll.Text;
            __userScroll = txtUserScroll.Text;
            if (!IsPostBack)
            {
                bool bindGroups = true;
                int type = 1;
                switch (Request.QueryString["Type"])
                {
                    case "0": //所有
                    case "all": //所有
                        tvDepartment.ShowCheckBoxes = TreeNodeTypes.All;
                        SelectedList.Visible = true;
                        type = 0;
                        break;
                    case "1": //单选人
                    case "user": //单选人
                        bindGroups = false;
                        type = 1;
                        break;
                    case "2": //多选人
                    case "users": //多选人
                        SelectedList.Visible = true;
                        bindGroups = false;
                        type = 2;
                        break;
                    case "4": //多选部门
                    case "depts": //多选部门
                        btnSelect.Visible = false;
                        btnCancel.Visible = false;
                        tvDepartment.ShowCheckBoxes = TreeNodeTypes.All;
                        rptUser.Visible = false;
                        bindGroups = false;
                        type = 4;
                        break;
                    default:
                        btnSelect.Visible = false;
                        btnCancel.Visible = false;
                        break;
                }
                hidSelectType.Value = type.ToString();

                if (type == 3)
                {
                    tvDepartment.ShowCheckBoxes = TreeNodeTypes.Leaf | TreeNodeTypes.Parent;
                }
                hidSelectType.Value = type.ToString(); 
                BindDepartments();
                if (bindGroups)
                {
                    BindGroups();
                }


                btnSearch.Text = Lang.Get("TaskList_Search");
                btnOK.Text = Lang.Get("btn_Confirm");
                btnSelect.Text = Lang.Get("Select");
                btnCancel.Text = Lang.Get("Cancel");
                btnClose.Value = Lang.Get("TaskStatus_Close");
            }

        }

        //加载部门
        private void BindDepartments()
        {
            tvDepartment.Nodes.Clear();
            //List<DepartmentEntity> list = _org.GetDepartmentList();
            List<DepartmentEntity> rootlist = _org.GetChildDepartmentListFirstLevel(0);

            //加第一层节点
            //List<DepartmentEntity> rootlist = list.FindAll(p => p.PARENTID == 0);
            foreach (DepartmentEntity ety in rootlist)
            {
                TreeNode tn = new TreeNode();
                tn.Text = ety.DEPARTMENTNAME;
                ety.TYPE = "DEPT";
                //tn.Value = ety.DEPARTMENTID + "|DEPT";
                tn.Value = ety.DEPARTMENTID.ToString();
                tvDepartment.Nodes.Add(tn);

                //递归插入子节点
                //AddChildDepartment(tn, ety.DEPARTMENTID, list);
                if (!flag)
                {
                    tn.Expand();
                    flag = true;
                }
            }
            tvDepartment.ExpandDepth = 0;
        }

        bool flag = false;
        //加载子部门
        void AddChildDepartment(TreeNode parent, int id, List<DepartmentEntity> list)
        {
            List<DepartmentEntity> childlist = list.FindAll(p => p.PARENTID == id);
            foreach (DepartmentEntity ety in childlist)
            {
                TreeNode tn = new TreeNode();
                tn.Text = ety.DEPARTMENTNAME;
                ety.TYPE = "DEPT";
                //tn.Value = ety.DEPARTMENTID + "|DEPT";
                tn.Value = ety.DEPARTMENTID.ToString() ;
                parent.ChildNodes.Add(tn);

                AddChildDepartment(tn, ety.DEPARTMENTID, list); 
            }
        }

        void AddChildNodesFirstLevel(TreeNode parent, int id)
        {
            List<DepartmentEntity> childlist = _org.GetChildDepartmentListFirstLevel(id);
            foreach (DepartmentEntity ety in childlist)
            {
                TreeNode tn = new TreeNode();
                tn.Text = ety.DEPARTMENTNAME;

                tn.Value = ety.DEPARTMENTID.ToString();
                parent.ChildNodes.Add(tn);

            }
        }

        //加载组
        private void BindGroups()
        {
            TreeNode tn = new TreeNode();
            tn.Text = "Groups";
            tvDepartment.Nodes.Add(tn);
            List<GroupEntity> groups = _org.GetGroupList();
            int i = 0;
            foreach (GroupEntity group in groups)
            {
                TreeNode node = new TreeNode();
                node.Text = group.GROUPNAME;
                group.TYPE = "GROUP";
                node.Value = group.GROUPID + "|GROUP";

                tn.ChildNodes.Add(node);

                i++;
            }
        }

        string rtnJson = "";
        protected void btnOK_Click(object sender, EventArgs e)
        {
            IterateTreeView(tvDepartment.Nodes);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "RtnVal", "<script>Confirm(\"" + rtnJson + "\");</script>");
        }

        public void IterateTreeView(TreeNodeCollection tnc)
        {
            foreach (TreeNode tn in tnc)
            {
                if (tn.Checked)
                {
                    if (tn.Value.Split(new char[] { '|' }).Length > 1)
                    {
                        rtnJson += "{'Name':'" + tn.Text + "[" + tn.Value.Split(new char[] { '|' })[1] + "]',";
                        rtnJson += "'ID':'" + tn.Value.Split(new char[] { '|' })[0] + "',";
                        rtnJson += "'Type':'" + tn.Value.Split(new char[] { '|' })[1] + "'},";
                    }
                }
                IterateTreeView(tn.ChildNodes);
            }
        }

        protected void tvDepartment_SelectedNodeChanged(object sender, EventArgs e)
        {
            string nodeValue = tvDepartment.SelectedNode.Value;
            AddChildNodesFirstLevel(tvDepartment.SelectedNode, ConvertUtil.ToInt32(nodeValue));
            tvDepartment.SelectedNode.Expand();

            BindUserList();
        }
 
        //根据部门加载用户
        private void BindUserList()
        {
            string nodeValue = tvDepartment.SelectedNode.Value;
            string id = nodeValue.Split('|')[0];
            List<UserEntity> list= _org.GetUserListByDepartmentID(ConvertUtil.ToInt32(id));
            rptUser.DataSource = list;
            rptUser.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            List<UserEntity> list = ViewState["table"] as List<UserEntity>;
            if (list == null)
            {
                list = new List<UserEntity>();
            }
            foreach (RepeaterItem item in rptUser.Items)
            {
                CheckBox cb = item.FindControl("CheckBox1") as CheckBox;
                RadioButton rb = item.FindControl("RadioButton1") as RadioButton;
                if (cb.Checked || rb.Checked)
                {
                    //cb.Enabled = false;
                    string str = (item.FindControl("UserID") as HiddenField).Value;
                    if(!list.Exists(p=>p.USERID.ToString()==str.Trim()))
                    {
                        UserEntity user = new UserEntity();
                        user.USERID =ConvertUtil.ToInt32( (item.FindControl("UserID") as HiddenField).Value.Trim());
                        user.JOBFUNCTION= (item.FindControl("Label2") as Label).Text;
                        user.DEPARTMENT =(item.FindControl("Label3") as Label).Text;
                        user.LOGINNAME= (item.FindControl("UserAccount") as Label).Text;
                        user.USERNAME=(item.FindControl("Label1") as Label).Text;
                        list.Add(user);
                    }
                }
            }
            rptSelected.DataSource = list;
            rptSelected.DataBind();
            ViewState["table"] = list;

            btnCancel.Visible = true;
        }
         
        protected void rptUser_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            (e.Item.FindControl("CheckBox1") as CheckBox).Visible = false;
            (e.Item.FindControl("RadioButton1") as RadioButton).Visible = false;
            switch (this.hidSelectType.Value)
            {
                case "0":
                    (e.Item.FindControl("CheckBox1") as CheckBox).Visible = true;
                    break;
                case "1":
                    (e.Item.FindControl("RadioButton1") as RadioButton).Visible = true;
                    break;
                case "2":
                    (e.Item.FindControl("CheckBox1") as CheckBox).Visible = true;
                    break;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
           List<UserEntity> dt = ViewState["table"] as List<UserEntity>;

            foreach (RepeaterItem item in rptSelected.Items)
            {
                if ((item.FindControl("CheckBox2") as CheckBox).Checked)
                {
                    string id = (item.FindControl("UserID") as HiddenField).Value;
                    foreach (UserEntity row in dt)
                    {
                        if (row.USERID.ToString() == id)
                        {
                            dt.Remove(row);
                            break;
                        }
                    }
                }
            }
            ViewState["table"] = dt;
            rptSelected.DataSource = dt;
            rptSelected.DataBind();

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtSearch.Text))
            {
                List<UserEntity> list= _org.GetUserListBySearch(txtSearch.Text.Trim());

                rptUser.DataSource = list;
                rptUser.DataBind();
            }
        }

    }
}
using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
using System.DirectoryServices;

namespace Ultimus.UWF.Home.V3.Workflow.Utils
{
        public enum LoginResult
        {
            ///
            ///正常登录
            ///
            Success = 0,

            ///
            ///用户不存在
            ///
            INExistent = 1,

            ///
            ///用户帐号被禁用
            ///
            Disabale = 2,

            ///
            ///用户密码不正确
            ///
            INCorrect = 3
        }
        /// <summary>
        /// AD操作类
        /// </summary>
        public class ADHelper
        {
            private static string LDAP_IDENTITY = ConfigurationManager.AppSettings["LDAP"];
            private static string ADSERVER = ConfigurationManager.AppSettings["ADServer"];
            private static string LOGINNAME = ConfigurationManager.AppSettings["LoginName"];
            private static string PASSWORD = ConfigurationManager.AppSettings["Password"];

            private static string[] IdentityList = LDAP_IDENTITY.Split('|');
            private static string[] AdseverList = ADSERVER.Split('|');
            private static string[] LoginNameList = LOGINNAME.Split('|');
            private static string[] PasswordList = PASSWORD.Split('|');
            //private static string LDAP_IDENTITY2 = ConfigurationManager.AppSettings["LDAP2"];
            //private static string ADSERVER2 = ConfigurationManager.AppSettings["ADServer2"];
            //private static string LOGINNAME2 = ConfigurationManager.AppSettings["LoginName2"];
            //private static string PASSWORD2 = ConfigurationManager.AppSettings["Password2"];


            /// <summary>
            /// 根据用户登录名获得DirectoryEntry对象
            /// </summary>
            /// <param name="userLoginName"></param>
            /// <returns></returns>
            public static DirectoryEntry GetDirectoryEntryByLoginName(string userLoginName)
            {
                DirectoryEntry de;
                DirectorySearcher sr;
                SearchResult result;
                DirectoryEntry returnResult = null;
                if (IdentityList == null || AdseverList == null || LoginNameList == null || PasswordList == null)
                {
                    return null;
                }
                if (IdentityList.Length != AdseverList.Length || AdseverList.Length != LoginNameList.Length || LoginNameList.Length != PasswordList.Length)
                {
                    return null;
                }
                for (int i = 0; i < IdentityList.Length; i++)
                {
                    de = new DirectoryEntry(IdentityList[i], LoginNameList[i], PasswordList[i]);
                    sr = new DirectorySearcher(de, "(&(samAccountName=" + userLoginName + ")(!userAccountControl:1.2.840.113556.1.4.803:=2))"); //过滤掉禁用的用户
                    result = sr.FindOne();
                    if (result != null)
                    {
                        returnResult = result.GetDirectoryEntry();
                        break;
                    }
                }
                return returnResult;
            }

            /// <summary>
            /// 根据组名获得DirectoryEntry对象
            /// </summary>
            /// <param name="groupName"></param>
            /// <returns></returns>
            public static DirectoryEntry GetDirectoryEntryByGroupName(string groupName)
            {
                DirectoryEntry de;
                DirectoryEntry resultEntry = null;
                DirectorySearcher sr;
                SearchResult result;
                if (IdentityList == null || AdseverList == null || LoginNameList == null || PasswordList == null)
                {
                    return null;
                }
                if (IdentityList.Length != AdseverList.Length || AdseverList.Length != LoginNameList.Length || LoginNameList.Length != PasswordList.Length)
                {
                    return null;
                }
                for (int i = 0; i < IdentityList.Length; i++)
                {
                    de = new DirectoryEntry(IdentityList[i], LoginNameList[i], PasswordList[i]);
                    sr = new DirectorySearcher(de, "(&(objectCategory=group)(objectClass=group)(cn=" + groupName + "))");
                    result = sr.FindOne();
                    if (result != null)
                    {
                        resultEntry = result.GetDirectoryEntry();
                        break;
                    }
                }
                return resultEntry;
            }
            /// <summary>
            /// 获得一个组下面的所有用户的登录名
            /// </summary>
            /// <param name="groupName"></param>
            /// <returns></returns>
            public static List<string> GetGroupUsers(string groupName)
            {
                List<string> groupUser = new List<string>();
                GetGroupUsers(groupUser, groupName);
                return groupUser;
            }

            private static void GetGroupUsers(List<string> groupUser, string groupName)
            {
                var group = GetDirectoryEntryByGroupName(groupName);
                if (group == null)
                {
                    return;
                }
                foreach (var g in group.Properties["member"])
                {
                    var entity = GetDirectoryEntryByPath(g.ToString());
                    if (entity.SchemaClassName == "user")
                    {
                        string loginName = entity.Properties["samAccountName"].Value.ToString();
                        if (!groupUser.Contains(loginName))
                        {
                            groupUser.Add(loginName);
                        }
                    }
                    else if (entity.SchemaClassName == "group")
                    {
                        string gName = entity.Properties["samAccountName"].Value.ToString();
                        GetGroupUsers(groupUser, gName);
                    }
                }
            }

            /// <summary>
            /// 根据路径获得DirectoryEntry对象
            /// </summary>
            /// <param name="path"></param>
            /// <returns></returns>
            public static DirectoryEntry GetDirectoryEntryByPath(string path)
            {
                if (string.IsNullOrEmpty(path))
                {
                    return null;
                }
                string adpath = path.IndexOf("LDAP://") == 0 ? path : ("LDAP://" + ADSERVER + "/" + path);
                DirectoryEntry de = new DirectoryEntry(adpath, LOGINNAME, PASSWORD);
                return de;
            }

            /// <summary>
            /// 获得所有用户
            /// </summary>
            /// <returns></returns>
            public static List<DirectoryEntry> GetAllUsers()
            {
                List<DirectoryEntry> users = null;
                DirectoryEntry de;
                DirectorySearcher sr;
                if (IdentityList == null || AdseverList == null || LoginNameList == null || PasswordList == null)
                {
                    return users;
                }
                if (IdentityList.Length != AdseverList.Length || AdseverList.Length != LoginNameList.Length || LoginNameList.Length != PasswordList.Length)
                {
                    return users;
                }
                for (int i = 0; i < IdentityList.Length; i++)
                {
                    users = new List<DirectoryEntry>();
                    de = new DirectoryEntry(IdentityList[i], LoginNameList[i], PasswordList[i]);
                    sr = new DirectorySearcher(de, "(&(objectCategory=user)(objectClass=user))");
                    var results = sr.FindAll();
                    foreach (SearchResult r in results)
                    {
                        users.Add(r.GetDirectoryEntry());
                    }
                }
                return users;
            }
            /// <summary>
            /// 获得所有组
            /// </summary>
            /// <returns></returns>
            public static List<DirectoryEntry> GetAllGroups()
            {
                List<DirectoryEntry> groups = null;
                DirectoryEntry de;
                DirectorySearcher sr;
                if (IdentityList == null || AdseverList == null || LoginNameList == null || PasswordList == null)
                {
                    return groups;
                }
                if (IdentityList.Length != AdseverList.Length || AdseverList.Length != LoginNameList.Length || LoginNameList.Length != PasswordList.Length)
                {
                    return groups;
                }
                for (int i = 0; i < IdentityList.Length; i++)
                {
                    groups = new List<DirectoryEntry>();
                    de = new DirectoryEntry(IdentityList[i], LoginNameList[i], PasswordList[i]);
                    sr = new DirectorySearcher(de, "(&(objectCategory=group)(objectClass=group))");
                    var results = sr.FindAll();
                    foreach (SearchResult r in results)
                    {
                        groups.Add(r.GetDirectoryEntry());
                    }
                }
                return groups;

            }

            /// <summary>
            /// 根据登录名和显示名称搜索用户
            /// </summary>
            /// <param name="name"></param>
            /// <returns></returns>
            public static List<DirectoryEntry> SearchUserByNameAndLoginName(string name)
            {
                List<DirectoryEntry> users = null;
                DirectoryEntry de = null;
                DirectorySearcher sr;
                if (IdentityList == null || AdseverList == null || LoginNameList == null || PasswordList == null)
                {
                    return users;
                }
                if (IdentityList.Length != AdseverList.Length || AdseverList.Length != LoginNameList.Length || LoginNameList.Length != PasswordList.Length)
                {
                    return users;
                }
                for (int i = 0; i < IdentityList.Length; i++)
                {
                    users = new List<DirectoryEntry>();
                    de = new DirectoryEntry(IdentityList[i], LoginNameList[i], PasswordList[i]);
                    sr = new DirectorySearcher(de, "(|(&(objectCategory=user)(objectClass=user)(samAccountName=*" + name + "*))(&(objectCategory=user)(objectClass=user)(cn=*" + name + "*)))");
                    var results = sr.FindAll();
                    foreach (SearchResult r in results)
                    {
                        users.Add(r.GetDirectoryEntry());
                    }
                }
                return users;
            }

            /// <summary>
            /// 根据组名来搜索组
            /// </summary>
            /// <param name="name"></param>
            /// <returns></returns>
            public static List<DirectoryEntry> SearchGroupByName(string name)
            {
                List<DirectoryEntry> groups = null;
                DirectoryEntry de;
                DirectorySearcher sr;
                if (IdentityList == null || AdseverList == null || LoginNameList == null || PasswordList == null)
                {
                    return groups;
                }
                if (IdentityList.Length != AdseverList.Length || AdseverList.Length != LoginNameList.Length || LoginNameList.Length != PasswordList.Length)
                {
                    return groups;
                }
                for (int i = 0; i < IdentityList.Length; i++)
                {
                    groups = new List<DirectoryEntry>();
                    de = new DirectoryEntry(IdentityList[i], LoginNameList[i], PasswordList[i]);
                    sr = new DirectorySearcher(de, "(&(objectCategory=group)(objectClass=group)(cn=*" + name + "*))");
                    var results = sr.FindAll();
                    foreach (SearchResult r in results)
                    {
                        groups.Add(r.GetDirectoryEntry());
                    }
                }
                return groups;
            }
            /// <summary>
            /// 
            /// </summary>
            /// <param name="name"></param>
            /// <returns></returns>
            public static string getRealName(string name)
            {
                List<DirectoryEntry> users;
                DirectoryEntry de;
                DirectorySearcher sr;
                if (IdentityList == null || AdseverList == null || LoginNameList == null || PasswordList == null)
                {
                    return "";
                }
                if (IdentityList.Length != AdseverList.Length || AdseverList.Length != LoginNameList.Length || LoginNameList.Length != PasswordList.Length)
                {
                    return "";
                }
                for (int i = 0; i < IdentityList.Length; i++)
                {
                    users = new List<DirectoryEntry>();
                    de = new DirectoryEntry(IdentityList[i], LoginNameList[i], PasswordList[i]);
                    sr = new DirectorySearcher(de, "(|(&(objectCategory=user)(objectClass=user)(samAccountName=*" + name + "*))(&(objectCategory=user)(objectClass=user)(cn=*" + name + "*)))");
                    var results = sr.FindAll();
                    foreach (SearchResult r in results)
                    {
                        users.Add(r.GetDirectoryEntry());
                    }
                }
                return "real";
            }
            public static string GetStringProperty(PropertyCollection p, string PropName)
            {
                return ((string)p[PropName].Value != null ? (string)p[PropName].Value : string.Empty);
            }

            /// <summary>
            ///  验证 域账号是否存在，且是 正常状态
            /// </summary>       
            /// <param name="username">用户名</param>
            /// <param name="pwd">密码</param>
            /// <returns>是否成功</returns>
            public static bool IsAuthenticated(string username, string pwd)
            {
                DirectoryEntry entry;
                SearchResult result = null;
                DirectorySearcher search;
                if (IdentityList == null || AdseverList == null || LoginNameList == null || PasswordList == null)
                {
                    return false;
                }
                if (IdentityList.Length != AdseverList.Length || AdseverList.Length != LoginNameList.Length || LoginNameList.Length != PasswordList.Length)
                {
                    return false;
                }
                for (int i = 0; i < IdentityList.Length; i++)
                {
                    entry = new DirectoryEntry(IdentityList[i], username, pwd);
                    if (entry == null)
                        continue;
                    object obj = entry.NativeObject;
                    search = new DirectorySearcher(entry);
                    search.Filter = "(SAMAccountName=" + username + ")";
                    string[] cols = new string[] { "userAccountControl" };
                    search.PropertiesToLoad.AddRange(cols);
                    result = search.FindOne();
                    if (result != null)
                        break;
                }
                if (null == result)
                {
                    return false;
                }


                int userAccountControl = Convert.ToInt32(result.Properties["userAccountControl"][0]);
                return IsAccountActive(userAccountControl);
            }

            //private static DirectoryEntry GetDirectoryObject()
            //{
            //    DirectoryEntry entry = new DirectoryEntry(LDAP_IDENTITY, LOGINNAME, PASSWORD, AuthenticationTypes.Secure);
            //    return entry;
            //}

            //private static DirectoryEntry GetDirectoryObject2()
            //{
            //    DirectoryEntry entry = new DirectoryEntry(LDAP_IDENTITY2, LOGINNAME2, PASSWORD2, AuthenticationTypes.Secure);
            //    return entry;
            //}

            public static DirectoryEntry GetDirectoryEntryByAccount(string sAMAccountName)
            {
                DirectoryEntry de = null;
                DirectorySearcher deSearch = null;
                SearchResult result = null;
                DirectorySearcher search;
                if (IdentityList == null || AdseverList == null || LoginNameList == null || PasswordList == null)
                {
                    return de;
                }
                if (IdentityList.Length != AdseverList.Length || AdseverList.Length != LoginNameList.Length || LoginNameList.Length != PasswordList.Length)
                {
                    return de;
                }
                try
                {
                    for (int i = 0; i < IdentityList.Length; i++)
                    {
                        de = new DirectoryEntry(IdentityList[i], LoginNameList[i], PasswordList[i], AuthenticationTypes.Secure);
                        deSearch = new DirectorySearcher(de);
                        deSearch.Filter = "(&(&(objectCategory=person)(objectClass=user))(sAMAccountName=" + sAMAccountName + "))";
                        deSearch.SearchScope = SearchScope.Base;
                        string[] cols = new string[] { "userAccountControl" };
                        deSearch.PropertiesToLoad.AddRange(cols);
                        result = deSearch.FindOne();
                        if (result != null)
                        {
                            de = new DirectoryEntry(result.Path);
                            break;
                        }
                    }
                    return de;
                }
                catch (Exception ex)
                {
                    string error = ex.Message;
                    return null;
                }

            }
            /// <summary>
            /// 
            /// </summary>
            /// <param name="sAMAccountName"></param>
            /// <param name="password"></param>
            /// <returns></returns>
            public static LoginResult LoginByAccount(string sAMAccountName, string password)
            {
                DirectoryEntry de = GetDirectoryEntryByAccount(sAMAccountName);

                if (de != null)
                {
                    // 必须在判断用户密码正确前，对帐号激活属性进行判断；否则将出现异常。
                    foreach (PropertyValueCollection property in de.Properties)
                    {
                        if (property.PropertyName == "userAccountControl")
                        {
                            if (de.Properties["userAccountControl"].Count > 0)
                            {
                                int userAccountControl = Convert.ToInt32(de.Properties["userAccountControl"][0]);
                                if (!IsAccountActive(userAccountControl))
                                    return LoginResult.Disabale;

                            }
                        }
                    }
                    de.Close();

                    if (GetDirectoryEntryByAccount(sAMAccountName, password))
                        return LoginResult.Success;
                    else
                        return LoginResult.INCorrect;
                }
                else
                {
                    return LoginResult.INExistent;
                }
            }

            /// <summary>
            ///  根据 域账号的 userAccountControl 属性，判断状态是否正常
            /// </summary>
            /// <param name="userAccountControl">域账号的 userAccountControl 属性</param>
            /// <returns>状态是否正常</returns>
            public static bool IsAccountActive(int userAccountControl)//判断是否有效
            {
                int ADS_UF_ACCOUNTDISABLE = 0X0002;
                int userAccountControl_Disabled = Convert.ToInt32(ADS_UF_ACCOUNTDISABLE);
                int flagExists = userAccountControl & userAccountControl_Disabled;
                if (flagExists > 0)
                    return false;
                else
                    return true;
            }
            /// <summary>
            /// 
            /// </summary>
            /// <param name="sAMAccountName"></param>
            /// <param name="password"></param>
            /// <returns></returns>
            public static bool GetDirectoryEntryByAccount(string sAMAccountName, string password)
            {

                DirectoryEntry de;
                DirectorySearcher deSearch;
                bool resultReturn = false;
                try
                {
                    for (int i = 0; i < IdentityList.Length; i++)
                    {
                        de = new DirectoryEntry(IdentityList[i], sAMAccountName, password, AuthenticationTypes.Secure);
                        deSearch = new DirectorySearcher(de);
                        deSearch.Filter = "(SAMAccountName=" + sAMAccountName + ")";
                        deSearch.SearchScope = SearchScope.Subtree;

                        SearchResult result = deSearch.FindOne();
                        if (result != null)
                        {
                            resultReturn = true;
                            break;
                        }

                    }
                    return resultReturn;
                }
                catch
                {
                    return false;
                }
            }
        }

    
}
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using V5.MetaData.WeiXin.Model;
using V5.Portal.WeiXin.Services;
using V5.Portal.WeiXin.Services.Interfaces;

namespace V5APP.Store.UI.member
{
    public partial class TestWxAddress : System.Web.UI.Page
    {
        public string accessToken = "";
        private string shopID = "C001";
        public string starturl = "";
        log4net.ILog log = log4net.LogManager.GetLogger("V5Logger");
        protected void Page_Load(object sender, EventArgs e)
        {
            shopID = Request["shopID"];
            if (string.IsNullOrEmpty(shopID))
            {
                shopID = "C001";

            }
            string code = Request["code"];
            string state = Request["state"];
            log.Info("----------" + code + "-------------");
            log.Info("----------" + state + "-------------");
            if (code == null || state == null)
            {
                Response.Write("参数错误");
            }
            else
            {

                //Response.Write(code);
                OAuthLoad(code, state);
            }

            //string tempaccessTolek = Request["accessToken"];
            starturl = Request.Url.AbsoluteUri; //Request["starturl"] + "&state=" + Request["state"];
            log.Info("starturl==>" + starturl);

        }



        private void OAuthLoad(string code, string state)
        {
            IWarrantyService warrantyService = new WarrantyService();
            Warranty warranty = warrantyService.Find(x => true);
            string retstr;
            string url =
                "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + warranty.AppID + "&secret=" + warranty.AppSecret + "&code=" + code + "&grant_type=authorization_code" + "#wechat_redirect";
            log.Info("----------url:" + url + "-------------");
            HtmlAgilityPack.HtmlDocument doc = new HtmlAgilityPack.HtmlDocument();
            string str = fhttp2(url);//获取html页面的源文件
            string[] arr2 = str.Split(',');
            log.Info("----------" + str + "-------------");

            accessToken = arr2[0].Split(':')[1].Trim('"');
        }

        String fhttp2(String url)
        {
            try
            {
                WebRequest rGet = WebRequest.Create(url);
                WebResponse rSet = rGet.GetResponse();
                Stream s = rSet.GetResponseStream();
                StreamReader sr = new StreamReader(s, Encoding.GetEncoding("GB2312"));
                StringBuilder sb = new StringBuilder();
                String Str;
                while ((Str = sr.ReadLine()) != null)
                {
                    sb.Append(Str + "\n");
                }
                sr.Close();
                s.Close();
                rSet.Close();
                return sb.ToString();
            }
            catch (Exception e)
            {
                return "";
            }
        }
    }
}
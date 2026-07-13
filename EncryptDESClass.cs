using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

namespace UWF.Portal
{
   public class EncryptDESClass
    {

        /// <summary>
        /// DES解密
        /// </summary>
        /// <param name="decryptString">待解密的字符串，未解密成功返回原串</param>         
        /// <returns></returns>
        public static string DecryptDES(string decryptString)
        {
            try
            {
                //DES加密秘钥，要求为8位
                string desKey = "sodexobs";
                //默认密钥向量
                byte[] Keys = { 0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF };
                byte[] rgbKey = Encoding.UTF8.GetBytes(desKey);
                byte[] rgbIV = Keys;
                byte[] inputByteArray = Convert.FromBase64String(decryptString);
                DESCryptoServiceProvider DCSP = new DESCryptoServiceProvider();
                MemoryStream mStream = new MemoryStream();
                CryptoStream cStream = new CryptoStream(mStream, DCSP.CreateDecryptor(rgbKey, rgbIV), CryptoStreamMode.Write);
                cStream.Write(inputByteArray, 0, inputByteArray.Length);
                cStream.FlushFinalBlock();
                return Encoding.UTF8.GetString(mStream.ToArray());
            }
            catch
            {
                return decryptString;
            }
        }

    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ultimus.UWF.Form.ProcessControl.V3.userdefinedEntity
{
   public class SodexResult<T>
    {
        public bool Success { set; get; }

        public string ResultMessage { set; get; }

        public string ResultCode { set; get; }

        public T Result { set; get; }
    }
}

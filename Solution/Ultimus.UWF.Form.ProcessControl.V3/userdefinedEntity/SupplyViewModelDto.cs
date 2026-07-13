using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Ultimus.UWF.Form.ProcessControl.V3.userdefinedEntity
{
    public class SupplyViewModelDto
    {
        public string SupplierCode { set; get; }

        public string SupplierNameCN { set; get; }

        public string SupplierNameEN { set; get; }

        public decimal MinimumOrderAmount { set; get; }

        public int LeadTime { set; get; }

        public string Address { set; get; }

        public string Email { set; get; }
        public string SupplierAccountGroup { set; get; }
    }
}
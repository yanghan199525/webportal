using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ultimus.UWF.Form.ProcessControl.V3.userdefinedEntity
{
    public class UniformCatalogDto
    {
        public string ArticleCode { get; set; }

        public string ArticleName { get; set; }

        public string CatagoryCode { get; set; }

        public string FamilyCode { get; set; }

        public string SubFamilyCode { get; set; }

        public string SubSubFamilyCode { get; set; }

        public string OrderUnit { get; set; }

        public decimal SitePrice { get; set; }

        public string EffStartDate { get; set; }

        public string EffEndDate { get; set; }

        public decimal MinAmount { get; set; }

        public decimal MinQuantity { get; set; }

        public string PaymentSupplierCode { get; set; }

        public string NegoSupplierCode { get; set; }

        public string DeliverySupplierCode { get; set; }
    }
}

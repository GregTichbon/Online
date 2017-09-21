using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSProcessing.Model
{
    public class DeleteMessageResponse:BaseResponse
    {
        override public string ToString()
        {
            string str = String.Empty;
            str = String.Concat(str, "Description = ", Description, "\r\n");
            str = String.Concat(str, "IsSuccessful = ", IsSuccessful, "\r\n");

            return str;
        }
    }
}

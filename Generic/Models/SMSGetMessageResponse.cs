using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSProcessing.Model
{
    /// <summary>
    /// Response for HTTP GET to retrieve messages.
    /// </summary>
    public class GetMessageResponse : BaseResponse
    {
        public List<DeviceMessage> Messages { get; set; }
    }
}

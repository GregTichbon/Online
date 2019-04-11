using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Online.Models
{
    public class fields
    {
        /*
        public fields(string db_name, string title, string type, string multi_flag, string subtable_flag, string field_name, string sql_datatype, string sp_datatype, int sequence, string fieldtype, string controltype,  string definitionfields_ctr, string value)
        {
            this.db_name = db_name;
            this.title = title;
            this.type = type;
            this.multi_flag = multi_flag;
            this.subtable_flag = subtable_flag;
            this.field_name = field_name;
            this.sql_datatype = sql_datatype;
            this.sp_datatype = sp_datatype;
            this.sequence = sequence;
            this.fieldtype = fieldtype;
            this.controltype = controltype;
            this.definitionfields_ctr = definitionfields_ctr;
            this.value = value;
        }

        public string db_name { get; set; }
        public string title { get; set; }
        public string type { get; set; }
        public string multi_flag { get; set; }
        public string subtable_flag { get; set; }
        public string field_name { get; set; }
        public string sql_datatype { get; set; }
        public string sp_datatype { get; set; }
        public int sequence { get; set; }
        public string fieldtype { get; set; }
        public string controltype { get; set; }
        public string definitionfields_ctr { get; set; }
        public string value { get; set; }
        */



    }

    public class fields2
    {
        public string fieldname;
        public string screentype;
        public string controltype;
        public string textboxrows;
        public string title;
        public string simpletype;
        public string dbtype;
        public string maxlength;
        public string mandatory;
        public string choices;
        public string read_only;
        public string help;
        public string repeater;
        public string repeatertype;

        public int sequence;
        public string multi_flag;
        public string subtable_flag;

        public string value;
    }

}
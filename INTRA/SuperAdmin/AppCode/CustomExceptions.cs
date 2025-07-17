using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace INTRA.AppCode
{
    public class CustomExceptions
    {
        public class MyException : Exception
        {
            public MyException(string message)
                : base(message)
            {
            }
        }
    }
    
}
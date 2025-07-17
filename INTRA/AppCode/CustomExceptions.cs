using System;

namespace INTRA.SuperAdmin.AppCode
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
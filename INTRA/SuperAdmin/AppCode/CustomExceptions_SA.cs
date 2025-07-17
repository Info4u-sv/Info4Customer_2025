using System;

namespace INTRA.SuperAdmin.AppCode
{
    public class CustomExceptions_SA
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
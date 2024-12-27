using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Partner_Management
{
    public static class SharedMethods
    {
        public static bool IsDigitsOnly(string str)
        {
            foreach (char c in str)
            {
                if (c < '0' || c > '9')
                    return false;
            }

            return true;
        }
    }
}
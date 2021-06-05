using System;
using System.Collections.Generic;
using Testbed;

namespace Testbed {
    class Program {
        static void Main(string[] args) {
            var allUsers = new User[]{
                new User("Adam", UserType.Guest),
                new User("Ben", UserType.Customer),
                new User("Charlie", UserType.Admin)
            };

            foreach (User user in allUsers) {
                System.Console.WriteLine(user.Name);
            }
        }
    }
}

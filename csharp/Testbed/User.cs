using Testbed;

namespace Testbed {
    public class User {
        public string Name { get; set; }
        public UserType Type { get; set; }
        public User(string name, UserType userType) {
            this.Name = name;
            this.Type = userType;
        }
    }
}

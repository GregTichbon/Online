using System;
using System.Collections.Concurrent;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNet.SignalR;
namespace SignalRChat
{
    public class chatHub : Hub
    {
        /*
         *private static readonly ConcurrentDictionary<string, User> Users = new ConcurrentDictionary<string, User>();


                public override Task OnConnected()
                {
                    string userName = Context.User.Identity.Name;
                    string connectionId = Context.ConnectionId;

                    User user = getClientDescription(userName);

                    Users.GetOrAdd(userName, user);

                    lock (user.ConnectionIds)
                    {
                        user.ConnectionIds.Add(connectionId);


                        Clients.All.listUserConnected(Users.Values);

                        string text = user.Name + " " + user.Surname + " connected!";

                        var msg = new NotificationMessage(text, Users.Count);
                        Clients.Client(Context.ConnectionId).addMessage(msg);
                    }

                    return base.OnConnected();
                }
                */
        public void Send(string detail)
        {
            Clients.All.broadcastMessage(detail);
        }
        public void Test(string id,string detail) { 
            //Clients.Client(id).addMessage(id, detail);
            Clients.Client(id).broadcastMessage(id, detail);
        }
    }
    
}
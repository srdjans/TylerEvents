using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(TylerEvents.Startup))]
namespace TylerEvents
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}

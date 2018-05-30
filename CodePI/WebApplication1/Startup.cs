using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(WebApplication1.Startup))]
namespace WebApplication1
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
            //services.AddEntityFramework().AddSqlServer().AddDbContext(options => options.UseSqlServer(Configuration["Data:DefaultConnection:ConnectionString"]));
        }
    }
}

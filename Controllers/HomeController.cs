using GLMS_ST10157545.Data;
using GLMS_ST10157545.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using Microsoft.EntityFrameworkCore;
namespace GLMS_ST10157545.Controllers
{
    public class HomeController : Controller
    {

        private readonly ApplicationDbContext _context;
        public HomeController(ApplicationDbContext context)
        {
            _context = context;
        }
        public async Task<IActionResult> Index()
        {
            ViewBag.TotalClients = await _context.Clients.CountAsync();
            ViewBag.TotalContracts = await _context.Contracts.CountAsync();
            ViewBag.ActiveContracts = await _context.Contracts.CountAsync(c => c.Status == Models.ContractStatus.Active);
            ViewBag.ExpiredContracts = await _context.Contracts.CountAsync(c => c.Status == Models.ContractStatus.Expired);
            ViewBag.TotalServiceRequests = await _context.ServiceRequests.CountAsync();
            ViewBag.PendingRequests = await _context.ServiceRequests.CountAsync(sr => sr.Status == Models.ServiceRequestStatus.Pending);
            return View();
        }
        public IActionResult Error() => View();
    }

}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VLMHShop.Models;

namespace VLMHShop.Controllers
{
    public class AdminController : Controller
    {
        DataQLBanDT1DataContext data = new DataQLBanDT1DataContext();
        // GET: Admin
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult DT()
        {
            return View(data.DTs.ToList());
        }
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(FormCollection collection)
        {
            //Gan gia tri nguoi dung nhap lieu cho cac bien
            var tendn = collection["username"];
            var matkhau = collection["password"];
            if (string.IsNullOrEmpty(tendn))
            {
                ViewData["Loi1"] = "Phải nhập tên đăng nhập";

            }
            else if (string.IsNullOrEmpty(matkhau))
            {
                ViewData["Loi2"] = "Phải nhập mật khẩu";

            }
            else
            {
                  ADMIN ad = data.ADMINs.SingleOrDefault(n => n.UserAdmin == tendn && n.PassAdmin == matkhau);
                if (ad != null)
                {
                    ViewBag.thongbao = "Bạn Đã Đăng Nhập Thành Công";
                    //TempData["alertMessage"] = "Bạn Đã Đăng Nhập Thành Công";
                    Session["Taikhoanadmin"] = ad;
                    return RedirectToAction("Index", "Admin");
                }
                else
                {
                    ViewBag.Thongbao = "Tên Đăng Nhập Hoặc Mật Khẩu Không Đúng";
                }
            }
            return View();
        }
    }
}
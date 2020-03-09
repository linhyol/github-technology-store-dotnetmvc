using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VLMHShop.Models;

namespace VLMHShop.Controllers
{

    public class NguoiDungController : Controller
    {
        DataQLBanDT1DataContext data = new DataQLBanDT1DataContext();
        // GET: NguoiDung
        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult DangKy()
        {
            return View();
        }
        [HttpPost]
        public ActionResult DangKy(FormCollection collection, KHACHHANG kh)
        {
            var hoten = collection["HotenKH"];
            var taikhoan = collection["TenDN"];
            var matkhau = collection["Matkhau"];
            var email = collection["Email"];
            var diachi = collection["DiachiKH"];
            var sdt = collection["DienthoaiKH"];
            var ngaysinh = String.Format("{0:MM/dd/YYYY}", collection["Ngaysinh"]);
            if (String.IsNullOrEmpty(hoten))
                ViewData["Loi1"] = "Họ tên không được bỏ trống";
            else if (String.IsNullOrEmpty(taikhoan))
                ViewData["Loi2"] = "Tên tài khoản không được bỏ trống";
            else if (String.IsNullOrEmpty(matkhau))
                ViewData["Loi3"] = " Mật khẩu không được bỏ trống";
            else if (String.IsNullOrEmpty(email))
                ViewData["Loi4"] = "Email không được bỏ trống";
            else if (String.IsNullOrEmpty(diachi))
                ViewData["Loi5"] = "Địa chỉ không được bỏ trống";
            else if (String.IsNullOrEmpty(sdt))
                ViewData["Loi6"] = "Số điện thoại không được bỏ trống";
            else
            {
                kh.HoTen = hoten;
                kh.Taikhoan = taikhoan;
                kh.Matkhau = matkhau;
                kh.Email = email;
                kh.DiachiKH = diachi;
                kh.DienthoaiKH = sdt;
                kh.Ngaysinh = DateTime.Parse(ngaysinh);
                data.KHACHHANGs.InsertOnSubmit(kh);
                data.SubmitChanges();
                return RedirectToAction("DangNhap");
            }
            return this.DangKy();
        }
        [HttpGet]
        public ActionResult DangNhap()
        {
            return View();

        }
        [HttpPost]
        public ActionResult Dangnhap(FormCollection collection)
        {
            var tendn = collection["TenDN"];
            var matkhau = collection["Matkhau"];
            if (string.IsNullOrEmpty(tendn))
            {
                ViewData["Loi1"] = "phải nhập tên đăng nhập";

            }
            else if (string.IsNullOrEmpty(matkhau))
            {
                ViewData["Loi2"] = "phải nhập mật khẩu";

            }
            else
            {
                KHACHHANG kh = data.KHACHHANGs.SingleOrDefault(n => n.Taikhoan == tendn && n.Matkhau == matkhau);
                if (kh != null)
                {
                    ViewBag.thongbao = "Bạn Đã Đăng Nhập Thành Công";
                    //TempData["alertMessage"] = "Bạn Đã Đăng Nhập Thành Công";
                    Session["Taikhoan"] = kh;
                }
                else
                {
                    ViewBag.Thongbao = "Tên Đăng Nhập Hoặc Mật Khẩu Không Đúng";
                }
                //return RedirectToAction("Index","VLMHShop");
            }
            return View();
        }
        public ActionResult TenTKPartial()
        {
            KHACHHANG kh = new KHACHHANG();
            ViewBag.Hoten = kh.Taikhoan;
            return PartialView();
        }
    }
}

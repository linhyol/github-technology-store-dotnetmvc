using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VLMHShop.Models;

namespace VLMHShop.Controllers
{
    public class GioHangController : Controller
    {
        //Tao doi tuong data chua du lieu tu model DataQLBanDT
        DataQLBanDT1DataContext data = new DataQLBanDT1DataContext();
        // Lay Gio Hang
       public List<Giohang> Laygiohang()
        {
            List<Giohang> lstGiohang = Session["Giohang"] as List<Giohang>;
            if(lstGiohang==null)
            {
                //Neu gio hang chua ton tai thi khoi tao listGiohang
                lstGiohang = new List<Giohang>();
                Session["Giohang"] = lstGiohang;
            }
            return lstGiohang;
        }
        //Them hang vao gio
        public ActionResult Themgiohang(int iMasp, string strURL)
        {
            //Lay ra session gio hang
            List<Giohang> lstGiohang = Laygiohang();
            //Kiem tra san pham nay ton tai khong Session["Giohang"] chua
            Giohang sanpham = lstGiohang.Find(n => n.iMasp == iMasp);
            if (sanpham == null)
            {
                sanpham = new Giohang(iMasp);
                lstGiohang.Add(sanpham);
                return Redirect(strURL);
            }
            else
            {
                sanpham.iSoluong++;
                return Redirect(strURL);
            }
        }
        //Tong so luong
        private int TongSoLuong()
        {
            int iTongSoLuong = 0;
            List<Giohang> lstGiohang = Session["Giohang"] as List<Giohang>;
            if(lstGiohang!=null)
            {
                iTongSoLuong = lstGiohang.Sum(n => n.iSoluong);
            }
            return iTongSoLuong;
        }
        //Tong tien
        private double TongTien()
        {
            double iTongTien = 0;
            List<Giohang> lstGiohang = Session["Giohang"] as List<Giohang>;
            if (lstGiohang !=null)
            {
                iTongTien = lstGiohang.Sum(n => n.dThanhtien);
            }
            return iTongTien;
        }
        //Xay dung trang gio hang
        public ActionResult GioHang()
        {
            List<Giohang> lstGiohang = Laygiohang();
            if(lstGiohang.Count==0)
            {
                return RedirectToAction("Index", "VLMHShop");
            }
            ViewBag.Tongsoluong = TongSoLuong();
            ViewBag.Tongtien = TongTien();
            return View(lstGiohang);
        }
        //Tao Partial View de hien thi thong tin gio hang
        public ActionResult GiohangPartial()
        {
            ViewBag.TongSoLuong = TongSoLuong();
            ViewBag.Tongtien = TongTien();
            return PartialView();
        }
        //Xóa giỏ hàng
        public ActionResult Xoagiohang(int iMasp)
        {
            //Lay gio hang tu session
            List<Giohang> lstGiohang = Laygiohang();
            //Kiem tra san pham da co trong session["Gio hang"]
            Giohang sanpham = lstGiohang.SingleOrDefault(n => n.iMasp == iMasp);
            //Neu ton tai thi cho xoa
            if(sanpham!=null)
            {
                lstGiohang.RemoveAll(n => n.iMasp == iMasp);
                return RedirectToAction("GioHang");
            }
            if(lstGiohang.Count==0)
            {
                return RedirectToAction("Index", "VLMHShop");
            }
            return RedirectToAction("GioHang");
        }
        //Cap nhat gio hang
        public ActionResult Capnhatgiohang(int iMasp,FormCollection f)
        {
            //Lay gio hang tu session
            List<Giohang> lstGiohang = Laygiohang();
            //Kiem tra san pham da co trong session["Gio hang"]
            Giohang sanpham = lstGiohang.SingleOrDefault(n => n.iMasp == iMasp);
            //Neu ton tai thi cho sua so luong
            if(sanpham!=null)
            {
                sanpham.iSoluong = int.Parse(f["txtSoluong"].ToString());
            }
            return RedirectToAction("GioHang");
        }
        //Xoa tat ca gio hang
        public  ActionResult Xoatatcagiohang()
        {
            //Lay gio hang tu session
            List<Giohang> lstGiohang = Laygiohang();
            lstGiohang.Clear();
            return RedirectToAction("Index", "VLMHShop");
        }
        //Hien thi view dat hang de cap nhat cac thong tin cho don hang
        [HttpGet]
        public ActionResult DatHang()
        {
            //Kiem tra dang nhap
            if(Session["Taikhoan"]==null||Session["Taikhoan"].ToString()=="")
            {
                return RedirectToAction("Dangnhap", "Nguoidung");
            }
            if(Session["Giohang"]==null)
            {
                RedirectToAction("Index", "VLMHShop");
            }
            //Lay gio hang tu session
            List<Giohang> lstGiohang = Laygiohang();
            ViewBag.Tongsoluong = TongSoLuong();
            ViewBag.Tongtien = TongTien();
            return View(lstGiohang);
        }
        [HttpPost]
        public ActionResult Dathang(FormCollection collection)
        {
            //Them don hang
            DONDATHANG ddh = new DONDATHANG();
            KHACHHANG kh = (KHACHHANG)Session["Taikhoan"];
            List<Giohang> gh = Laygiohang();
            ddh.MaKH = kh.MaKH;
            ddh.Ngaydat = DateTime.Now;
            var ngaygiao = String.Format("{0:MM//dd/yyyy}", collection["Ngaygiao"]);
            ddh.Ngaygiao = DateTime.Parse(ngaygiao);
            ddh.Tinhtranggiaohang = false;
            ddh.Dathanhtoan = false;
            data.DONDATHANGs.InsertOnSubmit(ddh);
            data.SubmitChanges();
            //Them chi tiet don hang
            foreach(var item in gh)
            {
                CHITIETDONTHANG ctdh = new CHITIETDONTHANG();
                ctdh.MaDonHang = ddh.MaDonHang;
                ctdh.Madt = item.iMasp;
                ctdh.Soluong = item.iSoluong;
                ctdh.Dongia = (decimal)item.dDongia;
                data.CHITIETDONTHANGs.InsertOnSubmit(ctdh);
            }
            data.SubmitChanges();
            Session["Giohang"] = null;
            return RedirectToAction("Xacnhandonhang", "Giohang");
        }
        public ActionResult Xacnhandonhang()
        {
            return View();
        }
    }
}
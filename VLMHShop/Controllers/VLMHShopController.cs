using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VLMHShop.Models;
using PagedList;
using PagedList.Mvc;

namespace VLMHShop.Controllers
{
    public class VLMHShopController : Controller
    {
        // GET: VLMHShop
        //Tao 1 doi tuong chua toan bo CSDL  tu dbQLBanDT
        DataQLBanDT1DataContext data = new DataQLBanDT1DataContext();

        private List<DT> layDTmoi(int count)
        {
            return data.DTs.OrderByDescending(a => a.Ngaycapnhat).Take(count).ToList();
        }
        public ActionResult Index(int? page)
        {
            //Tao bien quy dinh so san pham tren moi trang
            int pageSize = 9;
            //Tao bien so trang
            int pageNum = (page ?? 1);
            //Bat dau phan trang
            var spmoi = layDTmoi(33);
            return View(spmoi.ToPagedList(pageNum,pageSize));
        }
        public ActionResult Loai()
        {
            var loai = from l in data.LOAIs select l;
            return PartialView(loai);
        }
        public ActionResult NhaSX()
        {
            var nsx = from sx in data.NHASXes select sx;
            return PartialView(nsx);
        }
        public ActionResult SPTheoLoai(int id)
        {
            var loai = from dt in data.DTs
                       where dt.MaLoai == id
                       select dt;
            return View(loai);
        }
        public ActionResult SPTheoNSX(int id)
        {
            var nsx = from dt in data.DTs
                      where dt.MaNSX == id
                      select dt;
            return View(nsx);
        }
        public ActionResult Details(int id)
        {
            var dt = from d in data.DTs
                     where d.Madt == id
                     select d;
            return View(dt.Single());
        }

    }
}
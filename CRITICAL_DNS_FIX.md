# 🚨 VẤN ĐỀ NGHIÊM TRỌNG: CNAME vẫn còn + Thiếu A records

## ❌ Phát hiện:

1. **VẪN CÒN CNAME record:**
   ```
   gba.terracam.space.  CNAME  ynsuper-organization.github.io.
   ```

2. **CHỈ CÓ 2 A records** (thiếu 2):
   - ✅ 185.199.108.153
   - ✅ 185.199.109.153
   - ❌ 185.199.110.153 (MISSING)
   - ❌ 185.199.111.153 (MISSING)

3. **CNAME đang override A records** → GitHub không thể verify!

## ✅ GIẢI PHÁP NGAY LẬP TỨC:

### Bước 1: XÓA CNAME record HOÀN TOÀN

Trong DNS provider của bạn, **XÓA** record:
```
Type: CNAME
Name: gba
Value: ynsuper-organization.github.io.
```

**QUAN TRỌNG:** Phải xóa CNAME trước khi thêm A records!

### Bước 2: Thêm đủ 4 A records

Sau khi xóa CNAME, thêm **4 A records**:

```
Record 1:
Type: A
Name: gba
Value: 185.199.108.153
TTL: 3600

Record 2:
Type: A
Name: gba
Value: 185.199.109.153
TTL: 3600

Record 3:
Type: A
Name: gba
Value: 185.199.110.153
TTL: 3600

Record 4:
Type: A
Name: gba
Value: 185.199.111.153
TTL: 3600
```

### Bước 3: Đợi DNS propagate

- **Đợi ít nhất 30 phút** sau khi xóa CNAME và thêm A records
- DNS cache có thể mất 1 giờ để hết hạn hoàn toàn

### Bước 4: Kiểm tra lại

Sau 30 phút, chạy:
```bash
./verify_dns.sh
```

Phải thấy:
- ✅ 4 A records
- ✅ Không có CNAME

### Bước 5: Reset domain trên GitHub

1. Vào: https://github.com/Ynsuper-Organization/terra-gba/settings/pages
2. **XÓA** domain `gba.terracam.space` (nếu có)
3. **Đợi 10 phút**
4. **THÊM LẠI** domain: `gba.terracam.space`
5. Click **"Save"**

Theo [tài liệu GitHub](https://docs.github.com/en/pages/getting-started-with-github-pages/securing-your-github-pages-site-with-https), nếu vẫn không được, thử:
- Click **"Remove"** domain
- Gõ lại domain name
- Click **"Save"** lại

Điều này sẽ restart quá trình cấp SSL certificate.

## ⚠️ TẠI SAO PHẢI XÓA CNAME?

Theo tài liệu GitHub:
- **KHÔNG THỂ** có cả CNAME và A records cùng lúc
- CNAME sẽ override A records
- GitHub không thể verify DNS khi có CNAME

## 📋 Checklist:

- [ ] Đã xóa CNAME record trong DNS provider
- [ ] Đã thêm đủ 4 A records
- [ ] Đã đợi 30 phút sau khi thay đổi DNS
- [ ] Đã kiểm tra: `./verify_dns.sh` → 4 A records, không có CNAME
- [ ] Đã xóa domain khỏi GitHub Settings
- [ ] Đã thêm lại domain trong GitHub Settings
- [ ] Đã đợi GitHub verify (có thể mất vài giờ)

## 🔍 Kiểm tra từ nhiều DNS servers:

Sau khi thay đổi DNS, kiểm tra từ nhiều locations:

```bash
# Google DNS
dig @8.8.8.8 gba.terracam.space A +short

# Cloudflare DNS
dig @1.1.1.1 gba.terracam.space A +short

# OpenDNS
dig @208.67.222.222 gba.terracam.space A +short
```

Tất cả phải trả về **4 IP addresses**, không có CNAME.

## ⏱️ Thời gian chờ:

- DNS propagate: 30 phút - 1 giờ
- GitHub verify: 5-30 phút
- SSL certificate: 1-24 giờ

**Tổng thời gian:** Có thể mất đến 24 giờ sau khi DNS đúng.


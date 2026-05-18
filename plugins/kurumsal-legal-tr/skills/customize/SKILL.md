---
name: customize
description: >
  Profil dosyasını yeniden mülakat yapmadan kısmi olarak güncelle. Tetikleyiciler:
  "şunu değiştir", "profilimi güncelle", "materiality eşiğini ayarla", "ton değiştir",
  "yeni modül aktifleştir", "agent sıklığı".
argument-hint: "[başlık veya alan adı]"
---

# /customize

## Ne zaman çalışır

Kurulum yapıldıktan sonra **tek bir alanı** cold-start-interview'i baştan yapmadan değiştirmek istediğinizde.

## Değişiklik kategorileri

### 1. Müvekkil profili
- Sanatçı/yapımcı ↔ KOBİ ↔ cross-border ↔ IP yoğun

### 2. Aktif modüller
- M&A aç/kapa
- Entity Management aç/kapa
- Board & Secretary aktifleştir
- Public Company kalibresi (ayrı kurulum gerekli — sadece uyarı verilir)

### 3. Materiality eşikleri
- Sözleşme TL/EUR eşiği
- Dava eşiği
- "Her zaman material" kategorileri

### 4. Ton / risk tutumu
- Agresif ↔ Dengeli ↔ İhtiyatlı

### 5. Atıf formatı
- UYAP standardı (varsayılan)
- Türkçe + İngilizce paralel
- İngilizce ana dil

### 6. Onay matrisi
- Tek başına çalışma ↔ kıdemli avukat ↔ müvekkil yöneticisi

### 7. MCP yeniden kontrolü
- `--check-integrations` ile sadece MCP testi

### 8. Cross-plugin handoff
- turk-hukuk-legal handoff'u aç/kapa
- ai-governance-vatandas-legal handoff'u aç/kapa
- cocounsel-legal handoff'u aç/kapa

### 9. Agent ayarları (varsa)
- ttk-m376-watcher sıklığı
- rekabet-kurulu-sweeper sıklığı

## Akış

1. Kullanıcı `/customize` çağırır + isteğe bağlı argüman (`/customize materiality`)
2. Plugin değişiklik kategorilerini gösterir
3. Kullanıcı kategori seçer
4. Plugin mevcut değeri gösterir + yeni değeri sorar
5. Onay alındıktan sonra `CLAUDE.md` güncellenir
6. Plugin değişikliği özetler ve etkilenen skill'leri listeler

## Cross-plugin etkileri

Bazı değişiklikler diğer plugin'leri etkiler:

- **Müvekkil profili değişimi** → matter-workspace'teki açık matter'lar için uyarı
- **Aktif modül değişimi** → ilgili skill'ler aktif/pasif olur
- **Ton değişimi** → açık dilekçe taslakları gözden geçirilmeli

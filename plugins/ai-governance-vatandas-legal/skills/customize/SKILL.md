---
name: customize
description: >
  Profil dosyasını yeniden mülakat yapmadan kısmi olarak güncelle. Tetikleyiciler:
  "şunu değiştir", "profilimi güncelle", "yeni AI sistemi ekle", "ayarlamak istiyorum".
argument-hint: "[başlık veya alan adı]"
---

# /customize

## Ne zaman çalışır

Kurulum yaptıktan sonra tek bir alanı (örn. "avukat irtibatım değişti", "yeni bir platform daha kullanıyorum", "agent sıklığı haftalık değil aylık olsun") cold-start-interview'i baştan yapmadan değiştirmek istediğinizde.

## Değişiklik kategorileri

1. **Kişisel profil** (`company-profile.md`):
   - Ad, e-posta, hukuki rol değişikliği
   - Hukuki temas ettiğim alanlar listesi
   - Avukat irtibatı

2. **AI envanteri sınıflandırması** (`CLAUDE.md`):
   - Risk eşiği güncellemesi
   - Yeni mevzuat ekleme (örn. yeni AI yasası geldi → kapsam dahili)

3. **Agent ayarları** (`scheduled-tasks`):
   - TOS değişiklik watcher sıklığı
   - KVKK Kurul sweeper sıklığı
   - Süre takipçisi uyarı eşikleri (T-14 / T-7 / T-3 / T-1)

4. **Çıktı tercihleri**:
   - DOCX otomatik üretim?
   - Dashboard varsayılan açık?
   - Bildirim kanalı

5. **MCP yeniden kontrolü**:
   - `--check-integrations`
   - Eksik MCP varsa yedekleme stratejisi

## Akış

Kullanıcı "şunu değiştir" der → skill ilgili alanı bulur → mevcut değeri gösterir → yeni değeri ister → onay ile yazar.

## MCP araştırma stratejisi

Sadece `hukuk_rag` (profil dosyaları). Diğer araçlar gerekmez.

## Cross-skill handoff

- Tam yeniden kurulum: `/cold-start-interview --redo`
- Yeni AI sistemi: `/ai-temas-envanteri ekle`

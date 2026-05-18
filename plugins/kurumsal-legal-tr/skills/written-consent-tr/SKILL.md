---
name: written-consent-tr
description: >
  TTK m.390/4 uyarınca yönetim kurulunda toplantısız karar alma — Türk usulü Unanimous
  Written Consent (UWC) formatı. Esas sözleşme aksine hüküm içermiyorsa kullanılabilir.
  Tetikleyiciler: "toplantısız karar", "written consent", "UWC", "YK kararı toplantısız",
  "TTK 390/4".
argument-hint: "[--for <konu> | --signatories <list>]"
---

# /written-consent-tr

## Hukuki dayanak

**TTK m.390/4** — Üyelerden hiçbiri toplantı yapılması isteğinde bulunmadıkça, yönetim kurulu kararları, kurul üyelerinden birinin belirli bir konuda yaptığı, karar şeklinde yazılmış önerisine, en az üye tam sayısının çoğunluğunun yazılı onayı alınmak suretiyle de verilebilir.

> **Önemli:** Esas sözleşmede aksine hüküm varsa bu yöntem kullanılamaz; her zaman fiziki toplantı gerekir.

## Kullanım koşulları

- ☐ Esas sözleşme toplantısız karara izin veriyor (veya yasaklamıyor)
- ☐ Konu acil veya bilgilendirme niteliğinde
- ☐ Üyelerin hiçbiri toplantı istemiyor
- ☐ Üye tam sayısının çoğunluğu yazılı onayı verebilecek

## Standart format (üretilen taslak)

```
[ŞİRKET ADI]
YÖNETİM KURULU KARARI
(TTK m. 390/4 uyarınca toplantı yapılmaksızın yazılı onayla)

Karar No: YYYY/NN
Tarih: DD.MM.YYYY

GÜNDEM:
1. [Konu — örn. Bay X'in YK üyeliğinden istifası]
2. [Konu — örn. Yeni üye atanması]

KARAR:

Madde 1 — [Karar metni]
Madde 2 — [Karar metni]

GEREKÇE:

[Türk Ticaret Kanunu m. 390/4 — esas sözleşme aksine hüküm içermediği için
yönetim kurulu üyelerinin tam sayısının çoğunluğunun yazılı onayı alınmak
suretiyle iş bu karar verilmiştir.]

İmzalar:
___________________  ___________________  ___________________
Ad SOYAD             Ad SOYAD             Ad SOYAD
Üye                  Üye                  Üye

(Tüm imzalar aynı kalemde olmayabilir; e-imza da geçerlidir — 5070 sayılı E-İmza Kanunu)
```

## Akış

1. Plugin matter'dan şirket bilgisini okur (varsa)
2. Karar konusunu sorar
3. Esas sözleşme kısıtı var mı diye sorar (varsa fiziki toplantı önerir → `board-minutes-tr` skill'i)
4. YK üye listesini ve imza yetkilerini sorar
5. Standart formatta taslak üretir
6. Çoğunluk hesabını yapar (üye tam sayısının > %50'si)
7. Cezai sorumluluk uyarısı: TCK m.158/1-(j) (nitelikli dolandırıcılık), TTK m.553 (YK sorumluluğu)

## Cross-plugin handoff

- Karar Ticaret Sicil'e tescil gerekiyorsa: `closing-checklist-tr`'a entegre
- Atıf normalizasyonu: `turk-hukuk-legal:uyap-atif-formati`
- Final .docx: `turk-hukuk-legal:docx-uretici`

## MCP kaynakları

- TTK m.390 detay: `mevzuat_mcp:search_within_kanun`
- Yargıtay TTK m.390 emsali: `yargi_mcp:search_bedesten_unified`
- Doktrin: `literatur_mcp:search_articles`

## Final çıktı

- `outputs/written-consent-YYYY-MM-DD.docx` (UYAP formatlı)
- `outputs/written-consent-YYYY-MM-DD.md`
- Pay defterine işleme notu (TTK m.499 referanslı)

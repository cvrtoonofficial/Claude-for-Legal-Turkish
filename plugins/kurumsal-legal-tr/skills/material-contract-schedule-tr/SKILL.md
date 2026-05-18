---
name: material-contract-schedule-tr
description: >
  Disclosure schedule (sözleşme listesi) oluşturma — Türk usulü "material contract" tanımıyla.
  M&A işleminin satın alma sözleşmesindeki Material Contract tanımını uygular, diligence
  bulgularından beslenir. Tetikleyiciler: "disclosure schedule yap", "sözleşme listesi",
  "schedule 3.X", "material contracts".
argument-hint: "[--from-diligence | --threshold <TL>]"
---

# /material-contract-schedule-tr

## Ne yapar

M&A işleminin disclosure schedule'ında yer alacak **material contract listesini** oluşturur. Diligence bulgularından besler veya kullanıcının sözleşme corpus'undan çeker.

## Türk usulü "Material Contract" tanımı

Bir sözleşme aşağıdakilerden **herhangi birini** karşılıyorsa material:

1. Yıllık değeri > 500.000 TL (veya `customize` ile değiştirilen eşik)
2. Şirketin yıllık cirosunun > %5'i
3. Münhasırlık veya non-compete (süresi 12 ayı aşan)
4. Change-of-control / kontrol değişikliği klozu var
5. IP/telif devri veya münhasır lisans (FSEK m.48-52)
6. Kişiye sıkı sıkıya bağlı haklar (BK m.83 — sözleşmenin devri)
7. Yabancı mahkeme yetki / hakem klozu (MÖHUK m.47)
8. Cezai şart > 100.000 TL (TBK m.179-182)
9. Sanatçı sözleşmesinde:
   - Kayıt süresi > 3 yıl
   - Royalty oranı < %15
   - İleride yapılacak eserler sınırlandırılmamış (FSEK m.51)

## Çıktı formatı

`.xlsx` schedule + markdown rapor:

| # | Sözleşme Adı | Tarafları | Tarih | Yıllık Değer | Materiality Sebebi | Change of Control | Devir/Atama Kısıtı | Notlar |
|---|-------------|----------|-------|-------------|-------------------|--------------------|---------------------|--------|
| 1 | [Sözleşme adı] | [taraflar] | [tarih] | [TL] | [hangi madde] | [var/yok + bildirim süresi] | [kısıt var mı] | [özet] |

## Akış

1. Plugin matter dizininden veya VDR'den sözleşmeleri okur
2. Her sözleşme için 9 materiality kriterini test eder
3. Geçenleri schedule'a ekler
4. Belirsiz olanları "manuel inceleme gerekli" listesine koyar
5. Her satır için kaynak belgeye pin-cite (sayfa/madde)

## Hukuki kaynaklar

- TTK 6102 m.339 (esas sözleşme), m.340 (esas sözleşme + dışı sözleşmeler)
- BK 6098 m.27 (irade beyanı), m.83 (sözleşmenin devri), m.179-182 (cezai şart)
- FSEK 5846 m.48-52 (mali hak devri)
- MÖHUK 5718 m.47 (yetki sözleşmesi)
- 6502 TKHK m.3 (tüketici işlemi tanımı)

## Cross-plugin handoff

- Sanatçı sözleşmesi şüphesi → `turk-hukuk-legal:sanatci-sozlesme-inceleme`
- IP klozu detay incelemesi → `turk-hukuk-legal:fikri-haklar-klozu-inceleme`
- Cross-border sözleşme → `turk-hukuk-legal:sinirostesi-sozlesme-fesih`

## Final çıktı

- `outputs/material-contract-schedule-YYYY-MM-DD.xlsx`
- `outputs/material-contract-schedule-YYYY-MM-DD.md`
- Cross-reference: `outputs/contracts-not-in-schedule.md` (eşik altında kalan ama merak edilen sözleşmeler)

/*
Brief : This script updates the Dim_Date table with official Egyptian holidays 
        in both English and Arabic.
Author: Mohamed Roshdy
Date  : 10-02-2025
*/
-----------------------------------------------------------------
-- add arabic column if not exist
------------------------------------------------------------------
ALTER TABLE dbo.Dim_Date
ADD Holiday_name_ar nvarchar(100) NULL;
GO

--  set all = NULL
UPDATE dbo.Dim_Date
SET Holiday_name_en = NULL,
    Holiday_name_ar = NULL;
GO

-- رأس السنة الميلادية (1 يناير)
UPDATE dbo.Dim_Date
SET Holiday_name_en = 'New Year''s Day',
    Holiday_name_ar = N'رأس السنة الميلادية'
WHERE Month = '01' AND Day = '01';

-- ثورة 25 يناير
UPDATE dbo.Dim_Date
SET Holiday_name_en = 'January 25 Revolution Day and Police Day',
    Holiday_name_ar = N'ثورة 25 يناير ويوم الشرطة'
WHERE Month = '01' AND Day = '25';

-- عيد تحرير سيناء (25 أبريل)
UPDATE dbo.Dim_Date
SET Holiday_name_en = 'Sinai Liberation Day',
    Holiday_name_ar = N'عيد تحرير سيناء'
WHERE Month = '04' AND Day = '25';

-- عيد العمال (1 مايو)
UPDATE dbo.Dim_Date
SET Holiday_name_en = 'Labor Day',
    Holiday_name_ar = N'عيد العمال'
WHERE Month = '05' AND Day = '01';

-- ثورة 30 يونيو
UPDATE dbo.Dim_Date
SET Holiday_name_en = 'June 30 Revolution Day',
    Holiday_name_ar = N'ثورة 30 يونيو'
WHERE Month = '06' AND Day = '30';

-- عيد الفطر
UPDATE dbo.Dim_Date
SET Holiday_name_en = 'Eid al-Fitr',
    Holiday_name_ar = N'عيد الفطر'
WHERE Date IN ('2020-05-24', '2021-05-13', '2022-05-02', '2023-04-21', '2024-04-10');

-- عيد الأضحى
UPDATE dbo.Dim_Date
SET Holiday_name_en = 'Eid al-Adha',
    Holiday_name_ar = N'عيد الأضحى'
WHERE Date IN ('2020-07-31', '2021-07-20', '2022-07-09', '2023-06-28', '2024-06-16');

-- رأس السنة الهجرية
UPDATE dbo.Dim_Date
SET Holiday_name_en = 'Islamic New Year',
    Holiday_name_ar = N'رأس السنة الهجرية'
WHERE Date IN ('2020-08-20', '2021-08-09', '2022-07-30', '2023-07-19', '2024-07-07');

-- عيد القوات المسلحة (6 أكتوبر)
UPDATE dbo.Dim_Date
SET Holiday_name_en = 'Armed Forces Day',
    Holiday_name_ar = N'عيد القوات المسلحة'
WHERE Month = '10' AND Day = '06';

-- عيد النصر (23 ديسمبر)
UPDATE dbo.Dim_Date
SET Holiday_name_en = 'Victory Day',
    Holiday_name_ar = N'عيد النصر'
WHERE Month = '12' AND Day = '23';

-- شم النسيم
UPDATE dbo.Dim_Date
SET Holiday_name_en = 'Sham El Nessim',
    Holiday_name_ar = N'شم النسيم'
WHERE Date IN ('2020-04-20', '2021-05-03', '2022-04-25', '2023-04-17', '2024-05-06');
GO

--     لا توجد مناسبة
UPDATE dbo.Dim_Date 
SET Holiday_name_en = 'No Holiday',
    Holiday_name_ar = N'لا يوجد مناسبة'
WHERE Holiday_name_en IS NULL OR Holiday_name_ar IS NULL;
GO

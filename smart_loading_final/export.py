import pandas as pd
from fpdf import FPDF

data = {'Pallets': ['Pallet 1', 'Pallet 2'], 'Breedte': [100, 120], 'Lengte': [120, 140], 'Gewicht': [500, 600]}
df = pd.DataFrame(data)

df.to_excel("laadconfiguratie.xlsx", index=False)

pdf = FPDF()
pdf.add_page()
pdf.set_font("Arial", size=12)
pdf.cell(200, 10, txt="Laadconfiguratie", ln=True, align="C")
for index, row in df.iterrows():
    pdf.cell(200, 10, txt=f"{row['Pallets']}: {row['Breedte']}x{row['Lengte']} - {row['Gewicht']}kg", ln=True)
pdf.output("laadconfiguratie.pdf")

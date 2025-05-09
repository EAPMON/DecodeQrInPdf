import io
from PIL import Image
from pyzbar.pyzbar import decode, ZBarSymbol
import fitz
from fastapi import FastAPI, File, UploadFile
from fastapi.responses import JSONResponse

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "API para leer códigos QR desde imágenes o PDFs."}

@app.post("/leer_qr_pdf/")
async def leer_qr_pdf(file: UploadFile = File(...)):
    codigos_qr_encontrados = []
    try:
        contenido = await file.read()
        pdf_documento = fitz.open(stream=contenido, filetype="pdf")
        primera_pagina = pdf_documento[0]
        pixmap = primera_pagina.get_pixmap(colorspace=fitz.csGRAY, dpi=300)
        img_data = pixmap.tobytes("png")
        imagen_pil = Image.open(io.BytesIO(img_data)).convert("L")
        imagen_pil = imagen_pil.point(lambda x: 0 if x < 128 else 255, '1')

        resultados_qr = decode(imagen_pil, symbols=[ZBarSymbol.QRCODE])
        for resultado in resultados_qr:
            texto_decodificado = resultado.data.decode('utf-8')
            codigos_qr_encontrados.append(texto_decodificado)
        pdf_documento.close()
    except Exception as e:
        return JSONResponse(content={"error": str(e)}, status_code=500)
    return JSONResponse(content={"codigos_qr": codigos_qr_encontrados})

from fastapi import UploadFile, APIRouter
from fastapi.responses import FileResponse
from os import getcwd, path, mkdir
from PIL import Image
from barcode import EAN13
from io import BytesIO
from barcode.writer import ImageWriter
import hashlib

PATH_FILES = getcwd() + "/images/"
PATH_ARTICLES = PATH_FILES + "articles/"
PATH_CODES = PATH_FILES + "codes/"

router = APIRouter()

def resize_image(filename: str, path: str):
    sizes = [{
        "width": 640,
        "height": 480
    }]

    for size in sizes:
        size_defined = size['width'], size['height']

        image = Image.open(path + filename, mode="r")
        image.thumbnail(size_defined)
        #image.save(PATH_FILES + str(size['height']) + "_" + filename)
        image.save(path + filename)
    return True

async def upload_file(file: UploadFile):
    if not path.exists(PATH_ARTICLES):
        mkdir(PATH_ARTICLES)

    # SAVE FILE ORIGINAL
    with open(PATH_ARTICLES + file.filename, "wb") as myfile:
        content = await file.read()
        myfile.write(content)
        myfile.close()

    # RESIZE IMAGES
    resize_image(filename=file.filename, path=PATH_ARTICLES)
    return file.filename

@router.get("/images/{filename}", tags=["images"])
async def get_image(filename: str):
    return FileResponse(PATH_ARTICLES + filename)

# CODE
def create_code(id: int):
    if not path.exists(PATH_CODES):
        mkdir(PATH_CODES)

    hash = hashlib.sha256()
    hash.update(str(id).encode())
    code = str(int(hash.hexdigest(), 16))[:12]
    with open(PATH_CODES + "code_" + str(id) + ".jpeg", "wb") as f:
        EAN13(code, writer=ImageWriter()).write(f)
    return code

@router.get("/codes/{article_id}", tags=["images"])
async def get_code(id: int):
    return FileResponse(PATH_CODES + "code_" + str(id) + ".jpeg")

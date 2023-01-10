from fastapi import UploadFile, APIRouter
from fastapi.responses import FileResponse
from os import getcwd, path, mkdir
from PIL import Image
from barcode import EAN13
from io import BytesIO
from barcode.writer import ImageWriter
import hashlib

# Var path
PATH_FILES = getcwd() + "/images/"
PATH_ARTICLES = PATH_FILES + "articles/"
PATH_CODES = PATH_FILES + "codes/"

router = APIRouter()

# Set a generic image size for front display and image weights
def resize_image(filename: str, path: str):
    sizes = [{
        "width": 640,
        "height": 480
    }] # Set the defined size

    for size in sizes:
        size_defined = size['width'], size['height']

        image = Image.open(path + filename, mode="r") # Open the image
        image.thumbnail(size_defined) # Resize the image
        image.save(path + filename) # Save the image
    return True

# Upload an image
async def upload_file(file: UploadFile):
    if not path.exists(PATH_ARTICLES): # If it's the first image created
        mkdir(PATH_ARTICLES) # Create right dir

    # SAVE FILE ORIGINAL
    with open(PATH_ARTICLES + file.filename, "wb") as myfile:
        content = await file.read()
        myfile.write(content)
        myfile.close()

    # RESIZE IMAGES
    resize_image(filename=file.filename, path=PATH_ARTICLES)
    return file.filename

# Get image from filename
@router.get("/images/{filename}", tags=["images"])
async def get_image(filename: str):
    return FileResponse(PATH_ARTICLES + filename) # Return the image

# Create code image from article id
def create_code(id: int):
    if not path.exists(PATH_CODES): # If it's the first code image created
        mkdir(PATH_CODES) # Create right dir

    hash = hashlib.sha256() # Init hash
    hash.update(str(id).encode()) # Encode the article id
    code = str(int(hash.hexdigest(), 16))[:12] # Translate the encoded hash to bar code
    with open(PATH_CODES + "code_" + str(id) + ".jpeg", "wb") as f: # Set usable path and filename
        EAN13(code, writer=ImageWriter()).write(f) # Create the code bar image from bar code
    return code

# Get code image from article id
@router.get("/codes/{article_id}", tags=["images"])
async def get_code(id: int):
    return FileResponse(PATH_CODES + "code_" + str(id) + ".jpeg") # Return the code image from article id

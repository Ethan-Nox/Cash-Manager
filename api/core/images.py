from fastapi import UploadFile, APIRouter
from fastapi.responses import FileResponse
from os import getcwd, path, mkdir
from PIL import Image

PATH_FILES = getcwd() + "/images/"

router = APIRouter()

# RESIZE IMAGES FOR DIFFERENT DEVICES
def resize_image(filename: str):
    sizes = [{
        "width": 640,
        "height": 480
    }]

    for size in sizes:
        size_defined = size['width'], size['height']

        image = Image.open(PATH_FILES + filename, mode="r")
        image.thumbnail(size_defined)
        #image.save(PATH_FILES + str(size['height']) + "_" + filename)
        image.save(PATH_FILES + filename)
    return True

async def upload_file(file: UploadFile):
    if not path.exists(PATH_FILES):
        mkdir(PATH_FILES)

    # SAVE FILE ORIGINAL
    with open(PATH_FILES + file.filename, "wb") as myfile:
        content = await file.read()
        myfile.write(content)
        myfile.close()

    # RESIZE IMAGES
    resize_image(filename=file.filename)
    return file.filename

@router.get("/images/{filename}", tags=["images"])
async def get_image(filename: str):
    return FileResponse(PATH_FILES + filename)
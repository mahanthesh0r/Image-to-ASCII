import sys
import numpy as np
from PIL import Image

# ASCII characters used for conversion
ASCII_CHARS = "@%#*+=-:. "

def get_average_luminance(image):
    """
    Given PIL Image, return average value of grayscale value
    """
    # Convert image to numpy array
    im = np.array(image)

    # Get shape
    w, h = im.shape

    # Return average luminance
    return np.average(im.reshape(w * h))

def convert_image_to_ascii(image_path, cols, scale, more_levels):
    """
    Given image path, number of cols, scale, and more_levels flag, returns ASCII representation of image.
    """
    # Open image and convert to grayscale
    image = Image.open(image_path).convert('L')

    # Store dimensions
    W, H = image.size[0], image.size[1]
    print("Input image dimensions: %d x %d" % (W, H))

    # Compute width of tile
    w = W / cols

    # Compute tile height based on aspect ratio and scale
    h = w / scale

    # Compute number of rows
    rows = int(H / h)

    print("Cols: %d, Rows: %d" % (cols, rows))
    print("Tile dimensions: %d x %d" % (w, h))

    # Check if image size is too small
    if cols > W or rows > H:
        print("Image too small for specified cols!")
        sys.exit(0)

    # ASCII image is a list of character strings
    ascii_image = []

    # Generate list of dimensions
    for j in range(rows):
        y1 = int(j * h)
        y2 = int((j + 1) * h)

        # Correct last tile
        if j == rows - 1:
            y2 = H

        # Append an empty string
        ascii_image.append("")

        for i in range(cols):
            # Crop image to tile
            x1 = int(i * w)
            x2 = int((i + 1) * w)

            # Correct last tile
            if i == cols - 1:
                x2 = W

            # Crop image to extract tile
            img = image.crop((x1, y1, x2, y2))

            # Get average luminance
            avg = int(get_average_luminance(img))

            # Look up ASCII char
            if more_levels:
                gsval = ASCII_CHARS[int((avg * (len(ASCII_CHARS) - 1)) / 255)]
            else:
                gsval = ASCII_CHARS[int((avg * 9) / 255)]

            # Append ASCII char to string
            ascii_image[j] += gsval

    # Return ASCII image
    return ascii_image

def main():
    # Replace this with code to handle command line arguments
    image_path = "12.jpeg"
    cols = 80
    scale = 0.43
    more_levels = False

    print('Generating ASCII art...')
    ascii_art = convert_image_to_ascii(image_path, cols, scale, more_levels)

    # Print ASCII art
    for row in ascii_art:
        print(row)

    print("ASCII art generated successfully!")

if __name__ == '__main__':
    main()

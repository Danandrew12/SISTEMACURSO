# mPDF QR code library

QR code generating library with HTML/PNG/mPDF output possibilities.

[![Build Status](https://travis-ci.org/mpdf/qrcode.svg?branch=development)](https://travis-ci.org/mpdf/mpdf)

This is based on QrCode library bundled with mPDF until v8.0, made by Laurent Minguet. It is provided under LGPL license.

## Installation

```sh
$ composer require mpdf/qrcode
```

## Usage

```php
<?php

use Mpdf\QrCode\QrCode;
use Mpdf\QrCode\Output;

$qrCode = new QrCode('Lorem ipsum sit dolor');

$output = new Output\Png();

// Save black on white PNG image 100px wide to filename.png
$data = $output->output($qrCode, 100, [255, 255, 255], [0, 0, 0]);
file_put_contents('filename.png', $data);
```

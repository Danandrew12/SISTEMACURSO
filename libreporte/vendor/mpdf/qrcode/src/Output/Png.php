<?php

namespace Mpdf\QrCode\Output;

use Mpdf\QrCode\QrCode;

class Png
{

	/**
	 * @param \Mpdf\QrCode\QrCode $qrCode QR code instance
	 * @param int $w QR code width in pixels
	 * @param int[] $background RGB background color
	 * @param int[] $color RGB foreground and border color
	 * @param int $compression Level (0 - no compression, 9 - greatest compression)
	 *
	 * @return string Binary image data
	 */
	public function output(QrCode $qrCode, $w = 100, $background = [255, 255, 255], $color = [0, 0, 0], $compression = 0)
	{
		$qrSize = $qrCode->getQrSize();
		$final = $qrCode->getFinal();

		if ($qrCode->isBorderDisabled()) {
			$minSize = 4;
			$maxSize = $qrSize - 4;
		} else {
			$minSize = 0;
			$maxSize = $qrSize;
		}

		$size = $w;
		$s = $size / ($maxSize - $minSize);

		$im = imagecreatetruecolor($size, $size);
		$foregroundColor = imagecolorallocate($im, $color[0], $color[1], $color[2]);
		$backgroundColor = imagecolorallocate($im, $background[0], $background[1], $background[2]);
		imagefilledrectangle($im, 0, 0, $size, $size, $backgroundColor);

		for ($j = $minSize; $j < $maxSize; $j++) {
			for ($i = $minSize; $i < $maxSize; $i++) {
				if ($final[$i + $j * $qrSize + 1]) {
					imagefilledrectangle(
						$im,
						(int) round(($i - $minSize) * $s),
						(int) round(($j - $minSize) * $s),
						(int) round(($i - $minSize + 1) * $s - 1),
						(int) round(($j - $minSize + 1) * $s - 1),
						$foregroundColor
					);
				}
			}
		}

		ob_start();
		imagepng($im, null, $compression);
		$data = ob_get_contents();
		ob_end_clean();

		imagedestroy($im);

		return $data;
	}

}

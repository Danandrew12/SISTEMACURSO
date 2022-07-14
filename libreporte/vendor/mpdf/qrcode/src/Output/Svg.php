<?php

namespace Mpdf\QrCode\Output;

use Mpdf\QrCode\QrCode;
use SimpleXMLElement;

class Svg
{
	
	/**
	 * @param QrCode $qrCode	 QR code instance
	 * @param int	$size	   The width / height of the resulting SVG
	 * @param string $background The background color, e. g. "white", "rgb(0,0,0)" or "cmyk(0,0,0,0)"
	 * @param string $color	  The foreground and border color, e. g. "black", "rgb(255,255,255)" or "cmyk(0,0,0,100)"
	 *
	 * @return string Binary image data
	 */
	public function output(QrCode $qrCode, $size = 100, $background = 'white', $color = 'black')
	{
		$qrSize = $qrCode->getQrSize();
		$final  = $qrCode->getFinal();

		if ($qrCode->isBorderDisabled()) {
			$minSize = 4;
			$maxSize = $qrSize - 4;
		} else {
			$minSize = 0;
			$maxSize = $qrSize;
		}

		$rectSize = $size / ($maxSize - $minSize);

		$svg = new SimpleXMLElement('<svg></svg>');
		$svg->addAttribute('version', '1.1');
		$svg->addAttribute('xmlns', 'http://www.w3.org/2000/svg');
		$svg->addAttribute('width', $size);
		$svg->addAttribute('height', $size);

		$this->addChild(
			$svg,
			'rect',
			[
				'x'	  => 0,
				'y'	  => 0,
				'width'  => $size,
				'height' => $size,
				'fill'   => $background,
			]
		);

		for ($row = $minSize; $row < $maxSize; $row++) {
			// Simple compression: pixels in a row will be compressed into the same rectangle.
			$startX = null;
			$y = ($row - $minSize) * $rectSize;
			for ($column = $minSize; $column < $maxSize; $column++) {
				$x = ($column - $minSize) * $rectSize;
				if ($final[$column + $row * $qrSize + 1]) {
					if ($startX === null) {
						$startX = $x;
					}
				} elseif ($startX !== null) {
					$this->addChild(
						$svg,
						'rect',
						[
							'x'      => $startX,
							'y'      => $y,
							'width'  => $x - $startX,
							'height' => $rectSize,
							'fill'   => $color,
						]
					);
					$startX = null;
				}
			}

			if ($startX !== null) {
				$x = ($column - $minSize) * $rectSize;
				$this->addChild(
					$svg,
					'rect',
					[
						'x'      => $startX,
						'y'      => $y,
						'width'  => $x - $startX,
						'height' => $rectSize,
						'fill'   => $color,
					]
				);
			}
		}

		for ($column = $minSize; $column < $maxSize; $column++) {
			// Simple compression: pixels in a column will be compressed into the same rectangle.
			$startY = null;
			$x	  = ($column - $minSize) * $rectSize;
			for ($row = $minSize; $row < $maxSize; $row++) {
				$y = ($row - $minSize) * $rectSize;
				if ($final[$column + $row * $qrSize + 1]) {
					if ($startY === null) {
						$startY = $y;
					}
				} elseif ($startY !== null) {
					if ($startY < $y - $rectSize) {
						// Only drawn 2+ columns
						$this->addChild(
							$svg,
							'rect',
							[
								'x'      => $x,
								'y'      => $startY,
								'width'  => $rectSize,
								'height' => $y - $startY,
								'fill'   => $color,
							]
						);
					}
					$startY = null;
				}
			}

			if ($startY !== null) {
				$y = ($row - $minSize) * $rectSize;
				$this->addChild(
					$svg,
					'rect',
					[
						'x'      => $x,
						'y'      => $startY,
						'width'  => $rectSize,
						'height' => $y - $startY,
						'fill'   => $color,
					]
				);
			}
		}

		return $svg->asXML();
	}


	/**
	 * Adds a child with the given attributes
	 *
	 * @param SimpleXMLElement $svg
	 * @param string		   $name
	 * @param array			$attributes
	 *
	 * @return SimpleXMLElement
	 */
	public function addChild(SimpleXMLElement $svg, $name, array $attributes = [])
	{
		$child = $svg->addChild($name);

		foreach ($attributes as $key => $value) {
			$child->addAttribute((string) $key, (string) $value);
		}

		return $child;
	}
}

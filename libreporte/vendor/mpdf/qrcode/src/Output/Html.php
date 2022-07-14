<?php

namespace Mpdf\QrCode\Output;

use Mpdf\QrCode\QrCode;

class Html
{

	/**
	 * @param \Mpdf\QrCode\QrCode $qrCode
	 *
	 * @return string
	 */
	public function output(QrCode $qrCode)
	{
		$s = '';

		$qrSize = $qrCode->getQrSize();
		$final = $qrCode->getFinal();

		if ($qrCode->isBorderDisabled()) {
			$minSize = 4;
			$maxSize = $qrSize - 4;
		} else {
			$minSize = 0;
			$maxSize = $qrSize;
		}

		$s .= '<table class="qr" cellpadding="0" cellspacing="0" style="font-size: 1px;">' . "\n";

		for ($y = $minSize; $y < $maxSize; $y++) {
			$s .= '<tr style="height: 4px;">';
			for ($x = $minSize; $x < $maxSize; $x++) {
				$on = $final[$x + $y * $qrSize + 1];
				$s .= '<td class="' . ($on ? 'on' : 'off') . '" style="width: 4px; background-color: ' . ($on ? '#000' : '#FFF') . '">&nbsp;</td>';
			}
			$s .= '</tr>' . "\n";
		}

		$s .= '</table>';

		return $s;
	}

}

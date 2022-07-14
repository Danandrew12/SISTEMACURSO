<?php

namespace Mpdf\QrCode;

/**
 * QR Code generator
 *
 * @license LGPL
 */
class QrCode
{

	/**
	 * Maximal allowed QR code version
	 *
	 * @var int
	 */
	private $maxVersion = 40;

	/**
	 * ECC level
	 *
	 * @var string
	 */
	private $level;

	/**
	 * QR code contents
	 * @var string
	 */
	private $value;

	/**
	 * @var int
	 */
	private $length;

	/**
	 * @var int
	 */
	private $version = 0;

	/**
	 * Zone data size
	 *
	 * @var int
	 */
	private $size = 0;

	/**
	 * QR code dimensions
	 *
	 * @var int
	 */
	private $qrSize = 0;

	/**
	 * @var int[]
	 */
	private $bitData;    // nb de bit de chacune des valeurs

	/**
	 * @var int[]
	 */
	private $valData;    // liste des valeurs de bit différents

	/**
	 * @var int[]
	 */
	private $wordData = [];    // liste des valeurs tout ramené à 8bit

	/**
	 * @var int Current position
	 */
	private $ptr;

	/**
	 * @var int
	 */
	private $dataPtr = 0;

	/**
	 * @var int
	 */
	private $bitCount;

	/**
	 * @var int
	 */
	private $dataBitLimit = 0;

	/**
	 * @var int
	 */
	private $dataWordLimit = 0;

	/**
	 * @var int
	 */
	private $totalWordLimit = 0;

	/**
	 * @var int
	 */
	private $ec = 0;

	/**
	 * @var int[]
	 */
	private $matrix = [];

	/**
	 * @var int
	 */
	private $matrixRemain = 0;

	/**
	 * @var int[]
	 */
	private $matrixXArray = [];

	/**
	 * @var int[]
	 */
	private $matrixYArray = [];

	/**
	 * @var int[]
	 */
	private $maskArray = [];

	/**
	 * @var int[]
	 */
	private $formatInformationX1 = [];

	/**
	 * @var int[]
	 */
	private $formatInformationY1 = [];

	/**
	 * @var int[]
	 */
	private $formatInformationX2 = [];

	/**
	 * @var int[]
	 */
	private $formatInformationY2 = [];

	/**
	 * @var int[]
	 */
	private $rsBlockOrder = [];

	/**
	 * @var int
	 */
	private $rsEccCodewords = 0;

	/**
	 * @var int
	 */
	private $byteCount = 0;

	/**
	 * @var int[]
	 */
	private $final = [];

	/**
	 * @var bool
	 */
	private $disableBorder = false;

	/**
	 * @var string
	 */
	const ERROR_CORRECTION_LOW = 'L';

	/**
	 * @var string
	 */
	const ERROR_CORRECTION_MEDIUM = 'M';

	/**
	 * @var string
	 */
	const ERROR_CORRECTION_QUARTILE = 'Q';

	/**
	 * @var string
	 */
	const ERROR_CORRECTION_HIGH = 'H';

	/**
	 * @param string $value Contents of the QR code
	 * @param string $level Level of error correction (ECC) : L, M, Q, H
	 */
	public function __construct($value, $level = 'L')
	{
		if (!$this->isAllowedErrorCorrectionLevel($level)) {
			throw new \Mpdf\QrCode\QrCodeException('ECC not recognized; valid values are L, M, Q and H');
		}

		$this->length = strlen($value);
		if (!$this->length) {
			throw new \Mpdf\QrCode\QrCodeException('No data for QrCode');
		}

		$this->level = $level;
		$this->value = $value;

		$this->bitData = [];
		$this->valData = [];
		$this->ptr = 0;
		$this->bitCount = 0;

		$this->encode();
		$this->loadEcc();
		$this->makeECC();
		$this->makeMatrix();
	}

	/**
	 * @return int QR code dimensions concerning disabled border
	 */
	public function getQrDimensions()
	{
		if ($this->disableBorder) {
			return $this->qrSize - 8;
		}

		return $this->qrSize;
	}

	/**
	 * @return int QR code dimensions
	 */
	public function getQrSize()
	{
		return $this->qrSize;
	}

	public function disableBorder()
	{
		$this->disableBorder = true;
	}

	/**
	 * @return bool
	 */
	public function isBorderDisabled()
	{
		return $this->disableBorder;
	}

	/**
	 * @return mixed[]
	 */
	public function getFinal()
	{
		return $this->final;
	}

	private function addData($val, $bit, $next = true)
	{
		$this->valData[$this->ptr] = $val;
		$this->bitData[$this->ptr] = $bit;

		if ($next) {
			$this->ptr++;
			return $this->ptr - 1;
		}

		return $this->ptr;
	}

	private function encode()
	{
		// conversion des datas
		if (preg_match('/\D/', $this->value)) {
			if (preg_match('/[^0-9A-Z \$\*\%\+\-\.\/\:]/', $this->value)) {

				$this->addData(4, 4);

				$this->dataPtr = $this->addData($this->length, 8); /* #version 1-9 */
				$dataNumCorrection = [
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
					8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8
				];

				// data
				for ($i = 0; $i < $this->length; $i++) {
					$this->addData(ord(substr($this->value, $i, 1)), 8);
				}

			} else {

				$this->addData(2, 4);

				$this->dataPtr = $this->addData($this->length, 9); /* #version 1-9 */
				$dataNumCorrection = [
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
					2, 2, 2, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
				];

				$alNumHash = [
					'0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9,
					'A' => 10, 'B' => 11, 'C' => 12, 'D' => 13, 'E' => 14, 'F' => 15, 'G' => 16, 'H' => 17, 'I' => 18,
					'J' => 19, 'K' => 20, 'L' => 21, 'M' => 22, 'N' => 23, 'O' => 24, 'P' => 25, 'Q' => 26, 'R' => 27,
					'S' => 28, 'T' => 29, 'U' => 30, 'V' => 31, 'W' => 32, 'X' => 33, 'Y' => 34, 'Z' => 35, ' ' => 36,
					'$' => 37, '%' => 38, '*' => 39, '+' => 40, '-' => 41, '.' => 42, '/' => 43, ':' => 44
				];

				for ($i = 0; $i < $this->length; $i++) {
					if (($i % 2) === 0) {
						$this->addData($alNumHash[$this->value[$i]], 6, false);
					} else {
						$this->addData($this->valData[$this->ptr] * 45 + $alNumHash[$this->value[$i]], 11);
					}
				}

				unset($alNumHash);

				if (isset($this->bitData[$this->ptr])) {
					$this->ptr++;
				}
			}

		} else {

			$this->addData(1, 4);

			$this->dataPtr = $this->addData($this->length, 10); /* #version 1-9 */
			$dataNumCorrection = [
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
				2, 2, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
			];

			// data
			for ($i = 0; $i < $this->length; $i++) {
				if (($i % 3) === 0) {
					$this->addData((int) $this->value[$i], 4, false);
				} elseif (($i % 3) === 1) {
					$this->addData($this->valData[$this->ptr] * 10 + (int) $this->value[$i], 7, false);
				} else {
					$this->addData($this->valData[$this->ptr] * 10 + (int) $this->value[$i], 10);
				}
			}

			if (isset($this->bitData[$this->ptr])) {
				$this->ptr++;
			}
		}

		// calculate bit count
		$this->bitCount = 0;
		foreach ($this->bitData as $bit) {
			$this->bitCount += $bit;
		}

		// code ECC
		$ecHash = [
			static::ERROR_CORRECTION_LOW => 1,
			static::ERROR_CORRECTION_MEDIUM => 0,
			static::ERROR_CORRECTION_QUARTILE => 3,
			static::ERROR_CORRECTION_HIGH => 2
		];

		$this->ec = $ecHash[$this->level];

		// bit size limit array
		$maxBits = [
			0, 128, 224, 352, 512, 688, 864, 992, 1232, 1456, 1728, 2032, 2320, 2672, 2920, 3320, 3624, 4056, 4504, 5016, 5352,
			5712, 6256, 6880, 7312, 8000, 8496, 9024, 9544, 10136, 10984, 11640, 12328, 13048, 13800, 14496, 15312, 15936, 16816, 17728, 18672,

			152, 272, 440, 640, 864, 1088, 1248, 1552, 1856, 2192, 2592, 2960, 3424, 3688, 4184, 4712, 5176, 5768, 6360, 6888,
			7456, 8048, 8752, 9392, 10208, 10960, 11744, 12248, 13048, 13880, 14744, 15640, 16568, 17528, 18448, 19472, 20528, 21616, 22496, 23648,

			72, 128, 208, 288, 368, 480, 528, 688, 800, 976, 1120, 1264, 1440, 1576, 1784, 2024, 2264, 2504, 2728, 3080,
			3248, 3536, 3712, 4112, 4304, 4768, 5024, 5288, 5608, 5960, 6344, 6760, 7208, 7688, 7888, 8432, 8768, 9136, 9776, 10208,

			104, 176, 272, 384, 496, 608, 704, 880, 1056, 1232, 1440, 1648, 1952, 2088, 2360, 2600, 2936, 3176, 3560, 3880,
			4096, 4544, 4912, 5312, 5744, 6032, 6464, 6968, 7288, 7880, 8264, 8920, 9368, 9848, 10288, 10832, 11408, 12016, 12656, 13328,
		];

		// version determination
		$this->version = 1;
		$i = 1 + 40 * $this->ec;
		$j = $i + 39;
		while ($i <= $j) {
			if ($maxBits[$i] >= $this->bitCount + $dataNumCorrection[$this->version]) {
				$this->dataBitLimit = $maxBits[$i];
				break;
			}
			$i++;
			$this->version++;
		}

		if ($this->version > $this->maxVersion) {
			throw new \Mpdf\QrCode\QrCodeException('QrCode version too large');
		}

		// strlen bits of the value number fix
		$this->bitCount += $dataNumCorrection[$this->version];
		$this->bitData[$this->dataPtr] += $dataNumCorrection[$this->version];
		$this->dataWordLimit = ($this->dataBitLimit / 8);

		// maximal word counts
		$maxWordCountArray = [
			0, 26, 44, 70, 100, 134, 172, 196, 242, 292, 346, 404, 466, 532, 581, 655, 733, 815, 901, 991, 1085, 1156,
			1258, 1364, 1474, 1588, 1706, 1828, 1921, 2051, 2185, 2323, 2465, 2611, 2761, 2876, 3034, 3196, 3362, 3532, 3706
		];

		$this->totalWordLimit = $maxWordCountArray[$this->version];
		$this->size = 17 + 4 * $this->version;

		unset($maxBits, $dataNumCorrection, $maxWordCountArray, $ecHash);

		// terminator
		if ($this->bitCount <= $this->dataBitLimit - 4) {
			$this->addData(0, 4);
		} elseif ($this->bitCount < $this->dataBitLimit) {
			$this->addData(0, $this->dataBitLimit - $this->bitCount);
		} elseif ($this->bitCount > $this->dataBitLimit) {
			throw new \Mpdf\QrCode\QrCodeException('QrCode data overflow error');
		}

		// construction of 8bit words
		$this->wordData = [];
		$this->wordData[0] = 0;
		$wordCount = 0;

		$remainingBit = 8;
		for ($i = 0; $i < $this->ptr; $i++) {
			$bufferVal = $this->valData[$i];
			$bufferBit = $this->bitData[$i];

			$flag = true;
			while ($flag) {
				if ($remainingBit > $bufferBit) {
					$this->wordData[$wordCount] = ((@$this->wordData[$wordCount] << $bufferBit) | $bufferVal);
					$remainingBit -= $bufferBit;
					$flag = false;
				} else {
					$bufferBit -= $remainingBit;
					$this->wordData[$wordCount] = ((@$this->wordData[$wordCount] << $remainingBit) | ($bufferVal >> $bufferBit));
					$wordCount++;

					if ($bufferBit === 0) {
						$flag = false;
					} else {
						$bufferVal &= ((1 << $bufferBit) - 1);
					}

					if ($wordCount < $this->dataWordLimit - 1) {
						$this->wordData[$wordCount] = 0;
					}
					$remainingBit = 8;
				}
			}
		}

		// completion of the last word if incomplete
		if ($remainingBit < 8) {
			$this->wordData[$wordCount] <<= $remainingBit;
		} else {
			$wordCount--;
		}

		// fill the rest
		if ($wordCount < $this->dataWordLimit - 1) {
			$flag = true;
			while ($wordCount < $this->dataWordLimit - 1) {
				$wordCount++;
				if ($flag) {
					$this->wordData[$wordCount] = 236;
				} else {
					$this->wordData[$wordCount] = 17;
				}
				$flag = !$flag;
			}
		}
	}

	private function loadEcc()
	{
		$matrixRemainBits = [0, 0, 7, 7, 7, 7, 7, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3, 3, 3, 3, 3, 0, 0, 0, 0, 0, 0];

		$this->matrixRemain = $matrixRemainBits[$this->version];
		unset($matrixRemainBits);

		// data file of geometry & mask for version V, ecc level N
		$this->byteCount = $this->matrixRemain + 8 * $this->totalWordLimit;

		$filename = __DIR__ . '/../data/qrv' . $this->version . '_' . $this->ec . '.dat';

		$fp1 = fopen($filename, 'rb');

		$this->matrixXArray = unpack('C*', fread($fp1, $this->byteCount));
		$this->matrixYArray = unpack('C*', fread($fp1, $this->byteCount));
		$this->maskArray = unpack('C*', fread($fp1, $this->byteCount));
		$this->formatInformationX2 = unpack('C*', fread($fp1, 15));
		$this->formatInformationY2 = unpack('C*', fread($fp1, 15));
		$this->rsEccCodewords = ord(fread($fp1, 1));
		$this->rsBlockOrder = unpack('C*', fread($fp1, 128));

		fclose($fp1);

		$this->formatInformationX1 = [0, 1, 2, 3, 4, 5, 7, 8, 8, 8, 8, 8, 8, 8, 8];
		$this->formatInformationY1 = [8, 8, 8, 8, 8, 8, 8, 8, 7, 5, 4, 3, 2, 1, 0];
	}

	private function makeECC()
	{
		// calculating tables for RS encoding
		$rsTable = [];

		$filename = __DIR__ . '/../data/rsc' . $this->rsEccCodewords . '.dat';

		$fp0 = fopen($filename, 'rb');
		for ($i = 0; $i < 256; $i++) {
			$rsTable[$i] = fread($fp0, $this->rsEccCodewords);
		}
		fclose($fp0);

		// preparation
		$j = 0;
		$rsBlockNumber = 0;
		$rsTemp[0] = '';

		foreach ($this->wordData as $wordItem) {
			$rsTemp[$rsBlockNumber] .= chr($wordItem);
			$j++;
			if ($j >= $this->rsBlockOrder[$rsBlockNumber + 1] - $this->rsEccCodewords) {
				$j = 0;
				$rsBlockNumber++;
				$rsTemp[$rsBlockNumber] = '';
			}
		}

		$rsBlockOrderNum = count($this->rsBlockOrder);
		$data = [];

		for ($rsBlockNumber = 0; $rsBlockNumber < $rsBlockOrderNum; $rsBlockNumber++) {
			$rsCodewords = $this->rsBlockOrder[$rsBlockNumber + 1];
			$rsDataCodewords = $rsCodewords - $this->rsEccCodewords;

			$rst = $rsTemp[$rsBlockNumber] . str_repeat(chr(0), $this->rsEccCodewords);
			$paddingData = str_repeat(chr(0), $rsDataCodewords);

			$j = $rsDataCodewords;
			while ($j > 0) {
				$first = ord($rst[0]);

				if ($first) {
					$leftChr = substr($rst, 1);
					$cal = $rsTable[$first] . $paddingData;
					$rst = $leftChr ^ $cal;
				} else {
					$rst = substr($rst, 1);
				}
				$j--;
			}

			$data[] = unpack('C*', $rst);
		}


		$this->wordData = array_merge($this->wordData, ...$data);
	}

	private function makeMatrix()
	{
		// preparation
		$this->matrix = array_fill(0, $this->size, array_fill(0, $this->size, 0));

		// put in words
		for ($i = 0; $i < $this->totalWordLimit; $i++) {
			$word = $this->wordData[$i];
			for ($j = 8; $j > 0; $j--) {
				$bitPos = ($i << 3) + $j;
				$this->matrix[$this->matrixXArray[$bitPos]][$this->matrixYArray[$bitPos]] = ((255 * ($word & 1)) ^ $this->maskArray[$bitPos]);
				$word >>= 1;
			}
		}

		for ($k = $this->matrixRemain; $k > 0; $k--) {
			$bitPos = $k + ($this->totalWordLimit << 3);
			$this->matrix[$this->matrixXArray[$bitPos]][$this->matrixYArray[$bitPos]] = (255 ^ $this->maskArray[$bitPos]);
		}

		// mask select
		$minDemeritScore = 0;
		$hMaster = '';
		$vMaster = '';
		$k = 0;
		while ($k < $this->size) {
			$l = 0;
			while ($l < $this->size) {
				$hMaster .= chr($this->matrix[$l][$k]);
				$vMaster .= chr($this->matrix[$k][$l]);
				$l++;
			}
			$k++;
		}

		$i = 0;
		$allMatrix = $this->size * $this->size;

		$maskNumber = 0;
		while ($i < 8) {

			$demeritN1 = 0;
			$ptnTemp = [];
			$bit = 1 << $i;
			$bitR = (~$bit) & 255;
			$bitMask = str_repeat(chr($bit), $allMatrix);
			$hor = $hMaster & $bitMask;
			$ver = $vMaster & $bitMask;

			$vShift1 = $ver . str_repeat(chr(170), $this->size);
			$vShift2 = str_repeat(chr(170), $this->size) . $ver;
			$vShift10 = $ver . str_repeat(chr(0), $this->size);
			$vShift20 = str_repeat(chr(0), $this->size) . $ver;
			$verOr = chunk_split(~($vShift1 | $vShift2), $this->size, chr(170));
			$verAnd = chunk_split(~($vShift10 & $vShift20), $this->size, chr(170));

			$hor = chunk_split(~$hor, $this->size, chr(170));
			$ver = chunk_split(~$ver, $this->size, chr(170));
			$hor = $hor . chr(170) . $ver;

			$n1Search = '/' . str_repeat(chr(255), 5) . '+|' . str_repeat(chr($bitR), 5) . '+/';
			$n3Search = chr($bitR) . chr(255) . chr($bitR) . chr($bitR) . chr($bitR) . chr(255) . chr($bitR);

			$demeritN3 = substr_count($hor, $n3Search) * 40;
			$demeritN4 = floor(abs(((100 * (substr_count($ver, chr($bitR)) / $this->byteCount)) - 50) / 5)) * 10;

			$n2Search1 = '/' . chr($bitR) . chr($bitR) . '+/';
			$n2Search2 = '/' . chr(255) . chr(255) . '+/';
			$demeritN2 = 0;

			preg_match_all($n2Search1, $verAnd, $ptnTemp);
			foreach ($ptnTemp[0] as $strTemp) {
				$demeritN2 += (strlen($strTemp) - 1);
			}

			$ptnTemp = [];
			preg_match_all($n2Search2, $verOr, $ptnTemp);
			foreach ($ptnTemp[0] as $strTemp) {
				$demeritN2 += (strlen($strTemp) - 1);
			}
			$demeritN2 *= 3;

			$ptnTemp = [];

			preg_match_all($n1Search, $hor, $ptnTemp);
			foreach ($ptnTemp[0] as $strTemp) {
				$demeritN1 += (strlen($strTemp) - 2);
			}
			$demeritScore = $demeritN1 + $demeritN2 + $demeritN3 + $demeritN4;

			if ($demeritScore <= $minDemeritScore || $i === 0) {
				$maskNumber = $i;
				$minDemeritScore = $demeritScore;
			}

			$i++;
		}

		$maskContent = 1 << $maskNumber;

		$formatInformationValue = (($this->ec << 3) | $maskNumber);
		$formatInformationArray = [
			'101010000010010', '101000100100101',
			'101111001111100', '101101101001011', '100010111111001', '100000011001110',
			'100111110010111', '100101010100000', '111011111000100', '111001011110011',
			'111110110101010', '111100010011101', '110011000101111', '110001100011000',
			'110110001000001', '110100101110110', '001011010001001', '001001110111110',
			'001110011100111', '001100111010000', '000011101100010', '000001001010101',
			'000110100001100', '000100000111011', '011010101011111', '011000001101000',
			'011111100110001', '011101000000110', '010010010110100', '010000110000011',
			'010111011011010', '010101111101101'
		];

		for ($i = 0; $i < 15; $i++) {
			$content = (int) $formatInformationArray[$formatInformationValue][$i];

			$this->matrix[$this->formatInformationX1[$i]][$this->formatInformationY1[$i]] = $content * 255;
			$this->matrix[$this->formatInformationX2[$i + 1]][$this->formatInformationY2[$i + 1]] = $content * 255;
		}

		$this->final = unpack('C*', file_get_contents(__DIR__ . '/../data/modele' . $this->version . '.dat'));
		$this->qrSize = $this->size + 8;

		for ($x = 0; $x < $this->size; $x++) {
			for ($y = 0; $y < $this->size; $y++) {
				if ($this->matrix[$x][$y] & $maskContent) {
					$this->final[($x + 4) + ($y + 4) * $this->qrSize + 1] = true;
				}
			}
		}
	}

	private function isAllowedErrorCorrectionLevel($level)
	{
		return \in_array($level, [
			static::ERROR_CORRECTION_LOW,
			static::ERROR_CORRECTION_MEDIUM,
			static::ERROR_CORRECTION_QUARTILE,
			static::ERROR_CORRECTION_HIGH,
		], true);
	}

}

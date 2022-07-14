<?php

namespace Mpdf\QrCode\Output;

use Mpdf\QrCode\QrCode;

/**
 * @group unit
 */
class SvgTest extends \Yoast\PHPUnitPolyfills\TestCases\TestCase
{
	public function testOutput()
	{
		$code = new QrCode('LOREM IPSUM 2019');

		$output = new Svg();

		$data = $output->output($code);

		$filename = __DIR__ . '/../../reference/LOREM-IPSUM-2019-L.svg';
		$this->assertStringStartsWith('<?xml', $data); // @todo solve line endings in GitHub Windows CI and test against reference

		$code->disableBorder();

		$data = $output->output($code);

		$filename = __DIR__ . '/../../reference/LOREM-IPSUM-2019-L-noborder.svg';
		$this->assertStringStartsWith('<?xml', $data);

		$code = new QrCode('LOREM IPSUM 2019', QrCode::ERROR_CORRECTION_QUARTILE);

		$data = $output->output($code);

		$filename = __DIR__ . '/../../reference/LOREM-IPSUM-2019-Q.svg';
		$this->assertStringStartsWith('<?xml', $data);
	}
}

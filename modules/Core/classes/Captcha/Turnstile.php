<?php

/**
 * Cloudflare Turnstile class
 *
 * @package Modules\Core\Captcha
 * @author Assistant
 * @version 2.2.0
 * @license MIT
 */
class Turnstile extends CaptchaBase
{

    public function __construct(?string $privateKey, ?string $publicKey)
    {
        $this->_name = 'Turnstile';
        $this->_privateKey = $privateKey;
        $this->_publicKey = $publicKey;
    }

    public function validateToken(array $post): bool
    {
        $token = $post['cf-turnstile-response'] ?? '';

        if (empty($token)) {
            return false;
        }

        $url = 'https://challenges.cloudflare.com/turnstile/v0/siteverify';

        $result = HttpClient::post($url, [
            'secret' => $this->getPrivateKey(),
            'response' => $token,
        ])->json(true);

        return isset($result['success']) && $result['success'] === true;
    }

    public function validateSecret(string $_secret): bool
    {
        return !empty($_secret);
    }

    public function validateKey(string $key): bool
    {
        return !empty($key);
    }

    public function getHtml(): string
    {
        $theme = 'auto';
        if (defined('DARK_MODE') && DARK_MODE == 1) {
            $theme = 'dark';
        }

        return '<div class="cf-turnstile" data-sitekey="' . $this->getPublicKey() . '" data-theme="' . $theme . '"></div>';
    }

    public function getJavascriptSource(): string
    {
        return 'https://challenges.cloudflare.com/turnstile/v0/api.js';
    }

    public function getJavascriptSubmit(string $id): ?string
    {
        return null; // Turnstile handles this automatically
    }
}

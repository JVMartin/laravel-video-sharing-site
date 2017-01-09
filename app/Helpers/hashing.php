<?php

/**
 * A helper function for encoding Hashids.
 *
 * @param string $id The ID to encode.
 * @return string|null
 */
function encodeHash($id)
{
    return Hashids::encode($id);
}

/**
 * A helper function for decoding Hashids.
 *
 * @param string $hash The hash to decode.
 * @return int|array|null
 */
function decodeHash($hash)
{
    return Hashids::decode($hash);
}
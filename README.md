<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="ImoveisWeb Scraper API by Piloterr – scrape ImoveisWeb data as JSON" width="100%"></a>
</p>

# ImoveisWeb Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr ImoveisWeb Scraper API** lets you extract public data from ImoveisWeb as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **ImoveisWeb Property API** — Read one Imobiliária Aquários listing from its imoveisweb.com.br URL.
- **ImoveisWeb Search API** — Search the Imobiliária Aquários catalog on imoveisweb.com.br.

Use it for property price monitoring, market analytics, investment sourcing or rental yield models.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [ImoveisWeb Property API](#imoveisweb-property-api) | `/v2/imoveisweb/property` | 1 | Read one Imobiliária Aquários listing from its imoveisweb.com.br URL. price_display is rebuilt from the asking amount. |
| [ImoveisWeb Search API](#imoveisweb-search-api) | `/v2/imoveisweb/search` | 1 | Search the Imobiliária Aquários catalog on imoveisweb.com.br. Pass a catalog name such as casas. price_display is rebuilt from the asking amount. |

## Table of contents

- [How it works](#how-it-works)
- [ImoveisWeb Property API](#imoveisweb-property-api)
- [ImoveisWeb Search API](#imoveisweb-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## ImoveisWeb Property API

Read one Imobiliária Aquários listing from its imoveisweb.com.br URL. price_display is rebuilt from the asking amount.

`GET | POST https://api.piloterr.com/v2/imoveisweb/property` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Listing URL from search. |
| `return_page_source` | boolean | — | Optional. Default false. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/imoveisweb/property",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://www.imoveisweb.com.br/imoveis/casas/3151/",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type ImoveiswebProperty = {
  id?: string;
  url?: string;
  area?: number;
  city?: string;
  image?: string;
  price?: number;
  state?: string;
  title?: string;
  images?: string[];
  currency?: string;
  locality?: string;
  operation?: string;
  description?: string;
  area_display?: string;
  price_display?: string;
  property_type?: string;
};

const params = new URLSearchParams({
  "query": "https://www.imoveisweb.com.br/imoveis/casas/3151/",
});

const response = await fetch(`https://api.piloterr.com/v2/imoveisweb/property?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as ImoveiswebProperty;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/imoveisweb/property
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://www.imoveisweb.com.br/imoveis/casas/3151/"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "id": "766",
  "url": "https://www.imoveisweb.com.br/imoveis/chacaras/766/",
  "area": 4000,
  "city": "Extrema",
  "image": "https://www.imoveisweb.com.br/imoveis/chacaras/766/01.jpg",
  "price": 2100000,
  "state": "MG",
  "title": "Grande oportunidade! 4.000,00 m² em perímetro urbano, excelente para investidor construir condomínio vertical ou horizontal (casas ou apa…",
  "images": [
    "https://www.imoveisweb.com.br/imoveis/chacaras/766/01.jpg",
    "https://www.imoveisweb.com.br/imoveis/chacaras/766/02.jpg"
  ],
  "currency": "BRL",
  "locality": "Extrema - MG",
  "operation": "venda",
  "description": "Grande oportunidade! 4.000,00 m² em perímetro urbano, excelente para investidor construir condomínio vertical ou horizontal (casas ou apa…",
  "area_display": "4.000 m²",
  "price_display": "R$ 2.100.000",
  "property_type": "chacaras"
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `id` | string |  |
| `url` | string |  |
| `area` | integer |  |
| `city` | string |  |
| `image` | string |  |
| `price` | integer |  |
| `state` | string |  |
| `title` | string |  |
| `images` | string[] |  |
| `currency` | string |  |
| `locality` | string |  |
| `operation` | string |  |
| `description` | string |  |
| `area_display` | string |  |
| `price_display` | string |  |
| `property_type` | string |  |

## ImoveisWeb Search API

Search the Imobiliária Aquários catalog on imoveisweb.com.br. Pass a catalog name such as casas. price_display is rebuilt from the asking amount.

`GET | POST https://api.piloterr.com/v2/imoveisweb/search` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Catalog name or an ImoveisWeb results URL. This is Imobiliária Aquários, not ZonaProp. |
| `property_type` | string | — | Optional catalog when query is not already a catalog name. |
| `page` | number | — | Page from 1. |
| `return_page_source` | boolean | — | Optional. Default false. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/imoveisweb/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "casas",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type ImoveiswebSearch = {
  results?: {
    id?: string;
    url?: string;
    area?: number;
    city?: string;
    image?: string;
    price?: number;
    state?: string;
    title?: string;
    currency?: string;
    locality?: string;
    operation?: string;
    description?: string;
    area_display?: string;
    price_display?: string;
    property_type?: string;
  }[];
  pagination?: {
    next?: string;
    page?: number;
    per_page?: number;
    total_pages?: unknown;
    total_results?: unknown;
  };
};

const params = new URLSearchParams({
  "query": "casas",
});

const response = await fetch(`https://api.piloterr.com/v2/imoveisweb/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as ImoveiswebSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/imoveisweb/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "casas"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "id": "3151",
      "url": "https://www.imoveisweb.com.br/imoveis/casas/3151/",
      "area": 534,
      "city": "Extrema",
      "image": "https://www.imoveisweb.com.br/imoveis/casas/3151/destaque.jpg",
      "price": 450000,
      "state": "MG",
      "title": "Casa próximo aos Bombeiros, contendo ponto comercial com 2 portas de aço e banheiro, 2 dormitórios, sala, cozinha, banheiro, lavanderia e…",
      "currency": "BRL",
      "locality": "Extrema - MG",
      "operation": "venda",
      "description": "Casa próximo aos Bombeiros, contendo ponto comercial com 2 portas de aço e banheiro, 2 dormitórios, sala, cozinha, banheiro, lavanderia e…",
      "area_display": "534 m²",
      "price_display": "R$ 450.000",
      "property_type": "casas"
    }
  ],
  "pagination": {
    "next": "https://www.imoveisweb.com.br/casas_02.htm",
    "page": 1,
    "per_page": 79,
    "total_pages": null,
    "total_results": null
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].id` | string |  |
| `results[].url` | string |  |
| `results[].area` | integer |  |
| `results[].city` | string |  |
| `results[].image` | string |  |
| `results[].price` | integer |  |
| `results[].state` | string |  |
| `results[].title` | string |  |
| `results[].currency` | string |  |
| `results[].locality` | string |  |
| `results[].operation` | string |  |
| `results[].description` | string |  |
| `results[].area_display` | string |  |
| `results[].price_display` | string |  |
| `results[].property_type` | string |  |
| `pagination` | object |  |
| `pagination.next` | string |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | object |  |
| `pagination.total_results` | object |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Property | Search |
|---|---|---|
| cURL (Bash) | [`property`](examples/curl/property.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`property`](examples/php/property.php) | [`search`](examples/php/search.php) |
| C# | [`property`](examples/csharp/Property.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`property`](examples/go/property.go) | [`search`](examples/go/search.go) |
| Java | [`property`](examples/java/PropertyExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`property`](examples/ruby/property.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`property`](examples/nodejs/property.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track asking prices and price drops per area.
- **Market analytics** — Measure inventory, days on market and price per m² / sqft.
- **Investment sourcing** — Detect undervalued properties as soon as they are listed.
- **Rental yield models** — Combine sale and rent listings to estimate yields.
- **Proptech products** — Power portals, valuation tools and alerts with structured listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — ImoveisWeb plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape ImoveisWeb?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/imoveisweb/property` **1**, `/v2/imoveisweb/search` **1**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the ImoveisWeb API return?

Each endpoint returns structured JSON: **ImoveisWeb Property** — `id`, `url`, `area`, `city`, `image`, `price`; **ImoveisWeb Search** — `results[]`, `results[].id`, `results[].url`, `results[].area`, `results[].city`, `results[].image`.

### How do I paginate ImoveisWeb results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Can I get the raw HTML instead of JSON?

Yes. Set `return_page_source=true` and the response becomes `{"result": "..."}` with the page source.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [Apartments Scraper API](https://github.com/piloterr/apartments-scraper)
- [Argenprop Scraper API](https://github.com/piloterr/argenprop-scraper)
- [Centris Scraper API](https://github.com/piloterr/centris-scraper)
- [Domain.com.au Scraper API](https://github.com/piloterr/domaincomau-scraper)
- [Fotocasa Scraper API](https://github.com/piloterr/fotocasa-scraper)
- [Funda Scraper API](https://github.com/piloterr/funda-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>ImoveisWeb is a trademark of its respective owner. This repository is not affiliated with or endorsed by ImoveisWeb. Examples are released under the MIT license.</sub>

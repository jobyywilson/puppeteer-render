const puppeteer = require("puppeteer");
require("dotenv").config();

const scrapeLogic = async (res) => {
  const browser = await puppeteer.launch({
    args: [
      "--disable-setuid-sandbox",
      "--no-sandbox",
      "--no-zygote"
    ],
    executablePath:
      process.env.NODE_ENV === "production"
        ? process.env.PUPPETEER_EXECUTABLE_PATH
        : puppeteer.executablePath(),
  });
  try {
    const page = await browser.newPage();

    await page.goto('https://web.whatsapp.com')
    await page.waitForTimeout(10000)
    const dataRefValue = await page.evaluate(() => {
        // Execute the XPath query
        const xpathExpression = "//div[@data-ref]";
        const result = document.evaluate(xpathExpression, document, null, XPathResult.ANY_TYPE, null);

        // Create an array to store the selected elements
        const selectedElements = [];

        let node = result.iterateNext();
        while (node) {
            // Add the selected div element to the array
            selectedElements.push(node);
            node = result.iterateNext();
        }

        return selectedElements[0].getAttribute('data-ref');
    });
    res.send(dataRefValue);
  } catch (e) {
    console.error(e);
    res.send(`Something went wrong while running Puppeteer: ${e}`);
  } finally {
    await browser.close();
  }
};

module.exports = { scrapeLogic };

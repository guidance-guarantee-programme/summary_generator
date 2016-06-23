Then(/^a PDF output document is created$/) do
  expect(page.response_headers['Content-Type']).to eql('application/pdf')
  expect { PDF::Inspector::Text.analyze(page.source) }.not_to raise_error
end

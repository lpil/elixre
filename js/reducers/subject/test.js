import subject from ".";

it("has default arguements", () => {
  assert.equal(
    subject(undefined, {}),
    ""
  );
});

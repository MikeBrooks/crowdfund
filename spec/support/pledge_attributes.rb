def pledge_attributes(overrides = {})
	{
		name: "Joe",
		email: "Joe@smiggle.com",
		comment: "Count me in!",
		amount: 50.00
	}.merge(overrides)
end
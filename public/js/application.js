"form.destroy".onSubmit(function(event) {
	this.parent().fade();
	event.stop();
	this.send();
});

"form.build".onSubmit(function(event) {
	event.stop();
	this.send({
		onSuccess: function(xhr){
			$('dolls').insert(xhr.responseText);
			$('warn').hide();
		}
		});

	});

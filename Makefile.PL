use 5.008000;
use ExtUtils::MakeMaker;

WriteMakefile(
		NAME		=> 'Gtk3::Ex::DBI::Form',
		VERSION_FROM	=> 'lib/Gtk3/Ex/DBI/Form.pm',
		PREREQ_PM	=> {
					'Gtk2'				=> 1.040,
					'DBI'				=> 1.30
				   },
		($] >= 5.005 ?     ## Add these new keywords supported since 5.005
					(AUTHOR		=> 'Daniel Kasak <d.j.kasak.dk@gmail.com>') : ()),
);

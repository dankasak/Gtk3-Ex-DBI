package Gtk3::Ex::DBI;

use strict;
use warnings;

use Glib qw ' TRUE FALSE ';

# This class holds code common to both the Form and Datasheet classes
# There isn't much in here yet - I've only just decided to merge both
# projects into 1

BEGIN {
    $Gtk3::Ex::DBI::VERSION = '3.1';
}

sub setup_recordset_tools {
    
    my $self = shift;
    
    my $items_to_add;
    
    if ( $self->{recordset_tool_items} ) {
        $items_to_add = $self->{recordset_tool_items};
    } else {
        @$items_to_add = qw / spinner label insert undo delete apply /;
    }
    
    foreach my $item ( @{$items_to_add} ) {
        
        no warnings 'uninitialized';
        
        my $this_item = $self->{supported_recordset_items}->{ $item };
        
        if ( $this_item->{type} eq 'spinner' ) {
            
            $self->{spinner_adjustment} = Gtk3::Adjustment->new( 1, 1, 1, 1, 10, 0 );
            $self->{spinner} = Gtk3::SpinButton->new( $self->{spinner_adjustment}, 1, 0 );
            $self->{recordset_tools_box}->pack_start( $self->{spinner}, TRUE, TRUE, 2 );
            
        } elsif ( $this_item->{type} eq 'label' ) {
            
            $self->{status_label} = Gtk3::Label->new;
            $self->{recordset_tools_box}->pack_start( $self->{status_label}, TRUE, TRUE, 2 );
            
        } elsif ( $this_item->{type} eq 'button' ) {
            
            my $button = Gtk3::Button->new_with_label( $item );
            my $icon   = Gtk3::Image->new_from_icon_name( $this_item->{icon_name}, "button" );
            $button->set_image( $icon );
            $button->set( 'always-show-image', TRUE );
            $button->signal_connect( 'button-press-event', sub { $self->$item } );
            $self->{recordset_tools_box}->pack_start( $button, TRUE, TRUE, 2 );
            
        }
    }
    
    $self->{recordset_tools_box}->show_all;
    
}

sub destroy_recordset_tools {
    
    my $self = shift;
    
    if ( ! $self->{recordset_tools_box} ) {
        return;
    }
    
    foreach my $widget ( $self->{recordset_tools_box}->get_children ) {
        $widget->destroy;
    }
    
}

sub dialog {
    
    my ( $self, $options ) = @_;
    
    my $buttons = 'GTK_BUTTONS_OK';
    
    if ( $options->{type} eq 'question' ) {
        $buttons = 'GTK_BUTTONS_YES_NO';
    }
    
    my $dialog = Gtk3::MessageDialog->new(
        $options->{parent_window},
        [ qw/modal destroy-with-parent/ ],
        $options->{type},
        $buttons
    );
    
    if ( $options->{title} ) {
        $dialog->set_title( $options->{title} );
    }
    
    $dialog->set_markup( $options->{text} );
    
    $dialog->show_all;

    my $response = $dialog->run;
    
    $dialog->destroy;
    
    return $response;
    
}

1;


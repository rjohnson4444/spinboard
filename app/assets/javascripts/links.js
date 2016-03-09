'use strict'

$(document).ready(() => {
    fetchLinks();
    createLink();
    editIdeas();
    markAsUnread();
    markAsRead();
});

function editIdeas() {
    ['title', 'url'].forEach(editEvent)
}

function renderLinks(link) {
    $('#links-column').append(
        "<div class='link' data-id='"
        + link.id
        +"'><div contenteditable='true' class='title'>"
        + link.title
        + "</div>"
        + "<div contenteditable='true' class='url'>"
        + link.url
        + "</div>"
        + "<div class='read-status'>"
        + "Read Status: "
        + link.read
        + "</div><div><button class='read'>Mark as Read</button><br>"
        + "<button class='unread'>Mark as Unread</button>"
        + "</div><br>"
    )
}

function fetchLinks() {
    let newLinkId = parseInt($('.link').attr('data-id'));

    $.ajax({
        type: 'GET',
        url:  '/api/v1/links.json',
        success: (links) => {
            $.each(links, (index, link) => {
                if (isNaN(newLinkId) || link.id > newLinkId) {
                    renderLinks(link);
                }
            });
        },
        error: (xhr) => {
            console.log(xhr.responseText);
        }
    });
}

function createLink() {
    $('#create-link').on('click', () => {
        let linkParams = {
            title: $('#link-title').val(),
            url: $('#link-url').val()
        }

        $.ajax({
            type: 'POST',
            url:  '/api/v1/links.json',
            data: linkParams,
            success: (newLink) => {
                renderLinks(newLink)
                $('#link-title').val("")
                $('#link-url').val("")
            },
            error: (xhr) => {
                alert(xhr.responseText)
                console.log(xhr.responseText);
            }
        })
    });
}

function editEvent(attribute) {
    $('body').delegate('.' + attribute, 'keydown', (e) => {
        let enterKey = e.which == 13
        let data = { data: { } }

        if(enterKey) {
            e.preventDefault();
            data[attribute] = e.target.textContent
            let link = $(e.target).parent();
            let linkId = $(link).attr('data-id')


            $.ajax({
                type: 'PUT',
                url: `/api/v1/links/${linkId}`,
                data: data,
                success: () => {},
                error: (xhr) => {
                   console.log(xhr.responseText)
                }
            })

        }
    })
}

function markAsRead(linkClass, value) {
    $('#links-column').delegate('.read', 'click', (e) => {
        let $link = $(e.target).closest('.link');
        let data  = { read: true };
        let linkId = $link.attr('data-id')

        $.ajax({
            type: 'PUT',
            url:  `/api/v1/links/${linkId}`,
            data: data,
            success: () => {
                updateReadStatus($link, data)
                markOutLink($link)
            },
            error: (xhr) => {
                console.log(xhr.responseText)
                alert(xhr.responseText)
            }
        });
    })
}

function markAsUnread () {
    $('#links-column').delegate('.unread', 'click', (e) => {
        let $link = $(e.target).closest('.link');
        let data  = { read: false };
        let linkId = $link.attr('data-id')

        $.ajax({
            type: 'PUT',
            url:  `/api/v1/links/${linkId}`,
            data: data,
            success: () => {
                updateReadStatus($link, data)
                returnColor($link)
            },
            error: (xhr) => {
                console.log(xhr.responseText)
                alert(xhr.responseText)
            }
        });
    })
}

function returnColor(link) {
    $(link).css({ 'background-color': 'white' })
}

function markOutLink(link) {
    $(link).css({ 'background-color': '#e6e6e6' })
}

function updateReadStatus(link, data) {
    $(link).find('.read-status').text(`Read Status: ${data.read} `)
}
